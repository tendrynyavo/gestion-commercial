package model.proforma;

import java.io.File;
import jxl.*;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;

import java.util.*;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Session;
import javax.mail.Transport;
import jxl.write.WritableSheet;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.Label;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import model.demande.Proforma;
import model.produit.Produit;
import java.awt.Desktop;
import java.io.IOException;

public class Mail {
    private final static String filename = "C:/Users/Antsa/Desktop/Proforma.xls";

    public static void ouvrirExcel() {
        try {
            if (Desktop.isDesktopSupported()) {
                Desktop desktop = Desktop.getDesktop();
                if (desktop.isSupported(Desktop.Action.OPEN)) {
                    desktop.open(new File(filename));
                } else {
                    System.out.println("L'action OPEN n'est pas supportée sur ce système.");
                }
            } else {
                System.out.println("Le bureau n'est pas pris en charge sur ce système.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void envoieMail(String sender, String mdp, String recipient) throws Exception {

        String host = "smtp.gmail.com";
        int port = 465;

        Properties properties = System.getProperties();
        properties.put("mail.smtp.user", sender);
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", String.valueOf(port));
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.EnableSSL.enable", "true");
        properties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.setProperty("mail.smtp.socketFactory.fallback", "false");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(sender, mdp);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(sender));

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

            message.setSubject("Proforma");

            message.setText("Contenu test");

            Multipart multipart = new MimeMultipart();

            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText("Mes salutations, \n\nCi-joint le proforma selon votre demande.\n\nCordialement.");
            multipart.addBodyPart(messageBodyPart);

            messageBodyPart = new MimeBodyPart();

            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);

            message.setContent(multipart);

            Transport transport = session.getTransport("smtp");
            transport.send(message);
            System.out.println("Proforma envoyé");

        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }

    public static void creerExcel(Proforma p) throws Exception {
        try {
            WritableWorkbook workbook = Workbook.createWorkbook(new File(filename));
            WritableSheet sheet = workbook.createSheet("Proforma", 0);
            sheet.getSettings().setPaperSize(PaperSize.A4);
            sheet.getSettings().setOrientation(PageOrientation.LANDSCAPE);

            WritableCellFormat[] format = Mail.format();
            Mail.formater(sheet, p.getDate().toString(), p.getFournisseur().getNom(), p.getFournisseur().getMail(),
                    p.getSociete().getNom(), p.getSociete().getEmail());

            int i = 9;
            for (Produit prod : p.getProduits()) {
                i += 1;
                sheet.mergeCells(0, i, 1, i);
                sheet.addCell(new Label(0, i, prod.getNom(), format[4]));
                sheet.addCell(new jxl.write.Number(2, i, prod.getQuantite(), format[2]));
                sheet.addCell(new jxl.write.Number(3, i, prod.getPrix(), format[2]));
                sheet.addCell(new jxl.write.Number(4, i, prod.getTva(), format[2]));
                sheet.addCell(new jxl.write.Formula(5, i, "(E" + (i + 1) + "*D" + (i + 1) + ")/100", format[2]));
                sheet.addCell(new jxl.write.Formula(6, i, "(D" + (i + 1) + "+F" + (i + 1) + ")", format[2]));
                sheet.addCell(
                        new jxl.write.Formula(7, i, "(D" + (i + 1) + "+F" + (i + 1) + ")*C" + (i + 1) + "", format[2]));
            }

            Mail.footer(sheet, i);
            Mail.ajuster(sheet, 7, 20);
            workbook.write();
            workbook.close();

            System.out.println("Proforma générée avec succès.");
        } catch (WriteException e) {

        }
    }

    public static void ajuster(WritableSheet sheet, int ligne, int taille) {
        for (int i = 0; i <= ligne; i++) {
            sheet.setColumnView(i, taille);
        }
    }

    public static void formater(WritableSheet sheet, String date, String fournisseur, String adressef, String client,
            String adressec)
            throws Exception {
        WritableCellFormat[] format = Mail.format();
        sheet.mergeCells(0, 0, 7, 1);
        Label title = new Label(0, 0, "PROFORMA du " + date, format[0]);
        sheet.addCell(title);

        sheet.mergeCells(0, 2, 1, 2);
        sheet.addCell(new Label(0, 2, "Societe : " + fournisseur, format[1]));
        sheet.mergeCells(0, 4, 1, 4);
        sheet.addCell(new Label(0, 4, "Mail : " + adressef, format[1]));

        sheet.mergeCells(6, 5, 7, 5);
        sheet.addCell(new Label(6, 5, client, format[5]));
        sheet.mergeCells(6, 7, 7, 7);
        sheet.addCell(new Label(6, 7, adressec, format[5]));

        sheet.mergeCells(0, 9, 1, 9);
        sheet.addCell(new Label(0, 9, "Produit", format[3]));
        sheet.addCell(new Label(2, 9, "Quantite", format[3]));
        sheet.addCell(new Label(3, 9, "Prix HT(Ar)", format[3]));
        sheet.addCell(new Label(4, 9, "TVA(%)", format[3]));
        sheet.addCell(new Label(5, 9, "Montant TVA(Ar)", format[3]));
        sheet.addCell(new Label(6, 9, "Prix TTC(Ar)", format[3]));
        sheet.addCell(new Label(7, 9, "Montant(Ar)", format[3]));
    }

    public static WritableCellFormat[] format() throws Exception {
        WritableCellFormat[] format = new WritableCellFormat[6];
        WritableCellFormat titre = new WritableCellFormat(
                new WritableFont(WritableFont.ARIAL, 16, WritableFont.BOLD));
        titre.setAlignment(jxl.format.Alignment.CENTRE);
        titre.setBackground(jxl.format.Colour.LIGHT_BLUE);
        titre.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        titre.setWrap(true);

        WritableCellFormat fournisseur = new WritableCellFormat(
                new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD));
        fournisseur.setAlignment(jxl.format.Alignment.LEFT);
        fournisseur.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        fournisseur.setWrap(true);

        WritableCellFormat client = new WritableCellFormat(new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD));
        client.setAlignment(jxl.format.Alignment.RIGHT);
        client.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        client.setWrap(true);

        WritableCellFormat tsotra = new WritableCellFormat(new WritableFont(WritableFont.ARIAL, 12));
        tsotra.setAlignment(jxl.format.Alignment.RIGHT);
        tsotra.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        tsotra.setWrap(true);

        WritableCellFormat header = new WritableCellFormat(
                new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD));
        header.setAlignment(jxl.format.Alignment.CENTRE);
        header.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        header.setBackground(jxl.format.Colour.LIGHT_BLUE);
        header.setWrap(true);

        WritableCellFormat cell = new WritableCellFormat(new WritableFont(WritableFont.ARIAL, 12));
        cell.setAlignment(jxl.format.Alignment.CENTRE);
        cell.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        cell.setWrap(true);

        format[0] = titre;
        format[1] = fournisseur;
        format[2] = tsotra;
        format[3] = header;
        format[4] = cell;
        format[5] = client;
        return format;

    }

    public static void footer(WritableSheet sheet, int last) throws Exception {
        WritableCellFormat[] format = Mail.format();
        sheet.mergeCells(5, last + 2, 6, last + 2);
        sheet.addCell(new Label(5, last + 2, "Total general (Ar)", format[5]));
        sheet.addCell(new jxl.write.Formula(7, last + 2, "SOMME(H" + last + ":H" + (last + 1) + ")", format[2]));
        sheet.mergeCells(5, last + 3, 6, last + 3);
        sheet.addCell(new Label(5, last + 3, "TVA 20 %", format[5]));
        sheet.addCell(new jxl.write.Formula(7, last + 3, "(H" + (last + 3) + "*20)/100", format[2]));
        sheet.mergeCells(5, last + 4, 6, last + 4);
        sheet.addCell(new Label(5, last + 4, "Montant TOTAL (Ar)", format[5]));
        sheet.addCell(new jxl.write.Formula(7, last + 4, "H" + (last + 3) + "+H" + (last + 4), format[2]));
    }

}
