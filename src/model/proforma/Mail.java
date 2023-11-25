package model.proforma;


import java.io.File;
import jxl.*;
import java.util.*; 
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.activation.DataHandler;
import javax.mail.*; 
import javax.mail.internet.*; 
import javax.mail.Session; 
import javax.mail.Transport; 
import jxl.write.WritableSheet;
import jxl.write.Number;
import jxl.write.Label;
import jxl.write.Formula;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class Mail {

   public static void envoieMail(String sender,String mdp,String recipient,String filename) throws  Exception{
        //String recipient = "malalanirina030304@gmail.com";

        //String sender = "manoarysarobidy@gmail.com";

        //String mdp="wumw rzpf xzif jzxr";

        //String filename = "C:/Users/Antsa/Desktop/Classeur1.xlsx";
        
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

            message.setSubject("Voici votre Proforma ");

            message.setText("Contenu test");

            Multipart multipart = new MimeMultipart();

            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText("Test be");
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
   
   public static void creerExcel(String fileName) throws Exception
   {
       try {
            //String fileName = "C:/Users/Antsa/Desktop/Classeur.xls";
            WritableWorkbook workbook = Workbook.createWorkbook(new File(fileName));
            workbook.createSheet("Proforma", 0);
            WritableSheet ws = workbook.getSheet( 0 );
            Number n;
            Label l;
            Formula f;
            for ( int i = 0; i < 10; i++ )
            {

                n = new Number( 0, i, i );
                ws.addCell( n );

                l = new Label( 1, i, "fois" );
                ws.addCell( l );

                n = new Number( 2, i, i + 1 );
                ws.addCell( n );

                l = new Label( 3, i, "egal" );
                ws.addCell( l );

                f = new Formula(4, i, "A" + (i+1) + "*C" + (i+1) );
                ws.addCell( f );
            }
            workbook.write();
            workbook.close();
        } catch (WriteException e) {

        }
   }
   
}
