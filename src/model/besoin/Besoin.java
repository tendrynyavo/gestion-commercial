package model.besoin;

import java.sql.Date;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.produit.Produit;

public class Besoin extends BddObject {

    String description;
    @ColumnName("date_besoin")
    Date date;
    Produit[] produits;

    public String getDescription() {
        return description;
    }

    public Date getDate() {
        return date;
    }

    public Produit[] getProduits() {
        return produits;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setProduits(Produit[] produits) {
        this.produits = produits;
    }

    public Besoin() throws Exception {
        super();
        this.setTable("besoin");
        this.setPrimaryKeyName("id_besoin");
        this.setConnection("PostgreSQL");
    }
    
}
