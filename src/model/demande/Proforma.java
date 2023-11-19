package model.demande;

import java.sql.Connection;
import java.sql.Date;

import connection.BddObject;
import connection.annotation.ColumnName;
import model.besoin.Besoin;
import model.departement.Fournisseur;
import model.produit.*;

public class Proforma extends BddObject {
	
	@ColumnName("date_proforma")
	Date date;
	Fournisseur fournisseur;
	Produit[] produits;

	public Fournisseur getFournisseur() {
		return fournisseur;
	}

	public Proforma setFournisseur(Fournisseur fournisseur) {
		this.fournisseur = fournisseur;
		return this;
	}

	public void setDate(Date date){
		this.date = date;
	}

	public Date getDate(){
		return this.date;
	}

	public void setProduits( Produit[] produits ){
		this.produits = produits;
	}

	public Produit[] getProduits(){
		return this.produits;
	}

	public Proforma() throws Exception {
		super();
		this.setCountPK(7);
		this.setFunctionPK("nextval('s_proforma')");
		this.setPrefix("PROF");
		this.setTable("proforma");
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_proforma");
	}

	public void ajouterProduit(String id, String article, String quantite, String prixUnitaire, String tva) throws Exception {
        try (Connection connection = this.getConnection()) {
			Proforma proforma = (Proforma) new Proforma().setId(id);
            Produit produit = new Produit();
            produit.setId(article);
            produit.setQuantite(quantite);
			produit.setPrix(prixUnitaire);
			produit.setTva(tva);
            proforma.ajouterProduit(produit, connection);
            connection.commit();
        }
    }

	public void ajouterProduit(Produit produit, Connection connection) throws Exception {
        produit.setProforma(this);
        produit.setTable("detail_proforma");
        produit.setSerial(false);
        produit.insert(connection);
    }

	public void ajouterProduit(String id, String article, String quantite) throws Exception {
        try (Connection connection = this.getConnection()) {
            Proforma proforma = this.getProforma(id, connection);
            Produit produit = new Produit();
            produit.setId(article);
            produit.setQuantite(quantite);
            proforma.ajouterProduit(produit, connection);
            connection.commit();
        }
    }

	public Proforma getProforma(String id, Connection connection) throws Exception {
        boolean connect = false;
        Proforma proforma = null;
        try {
			if (id == null) return null;
			if (connection == null) {
				connection = this.getConnection();
                connect = true;
            }
            proforma = (Proforma) new Proforma().setId(id).getById(connection);
            Produit produit = new Produit();
            produit.setProforma(proforma);
            produit.setTable("v_proforma");
            if (proforma != null) {
				proforma.setProduits((Produit[]) produit.findAll(connection, "nom"));
            }
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return proforma;
    }

}