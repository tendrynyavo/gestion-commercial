package model.validation;

import java.io.File;
import java.io.IOException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;

import connection.BddObject;

public class Validation extends BddObject {

    Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStringStatus() {
        String status = null;
        switch (this.getStatus()) {
            case 25:
                status = "Confirmer";
                break;

            case 20:
                status = "Valider";
                break;

            case 15:
                status = "En attente de bon de commande";
                break;

            case 10:
                status = "Post-valide";
                break;

            case 0:
                status = "En attente";
                break;

            default:
                status = "";
                break;
        }
        return status;
    }

    public Validation() throws Exception {
        super();
    }

    public static void main(String args[]) throws IOException {

        PDDocument document = new PDDocument();

        // Retrieving the pages of the document
        PDPage page = new PDPage();
        document.addPage(page);
        PDPageContentStream contentStream = new PDPageContentStream(document, page);

        // Begin the Content stream
        contentStream.beginText();

        // Setting the font to the Content stream
        contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);

        // Setting the position for the line
        contentStream.newLineAtOffset(25, 725);

        String text = "This is the sample document and we are adding content to it.";

        // Adding text in the form of string
        contentStream.showText(text);

        contentStream.newLine();

        contentStream.showText("Hello World");

        // Ending the content stream
        contentStream.endText();

        System.out.println("Content added");

        // Closing the content stream
        contentStream.close();

        // Saving the document
        document.save(new File("./test.pdf"));

        // Closing the document
        document.close();

    }

}