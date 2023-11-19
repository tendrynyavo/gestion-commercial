package model.besoin;

import java.sql.Connection;
import java.sql.Date;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.employe.Employe;
import model.produit.Produit;

public class Besoin extends BddObject {

    String description;
    @ColumnName("date_besoin")
    Date date;
    Employe employe;
    Produit[] produits;

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

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
        this.setFunctionPK("nextval('s_besoin')");
        this.setCountPK(6);
        this.setPrefix("BES");
        this.setConnection("PostgreSQL");
    }

    public Besoin getBesoin(String id, Connection connection) throws Exception {
        boolean connect = false;
        Besoin besoin = null;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            besoin = (Besoin) new Besoin().setId(id).getById(connection);
            Produit produit = new Produit();
            produit.setBesoin(besoin);
            produit.setTable("v_demande");
            if (besoin != null) {
                besoin.setProduits((Produit[]) produit.findAll(connection, "nom"));
            }
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return besoin;
    }

    public void ajouterProduit(String id, String article, String quantite) throws Exception {
        try (Connection connection = this.getConnection()) {
            Besoin besoin = this.getBesoin(id, connection);
            Produit produit = new Produit();
            produit.setId(article);
            produit.setQuantite(quantite);
            besoin.ajouterProduit(produit, connection);
            connection.commit();
        }
    }

    public void ajouterProduit(Produit produit, Connection connection) throws Exception {
        produit.setBesoin(this);
        produit.setTable("demande");
        produit.setSerial(false);
        produit.insert(connection);
    }
    
}
