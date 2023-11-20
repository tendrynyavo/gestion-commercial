package model.departement;

import java.sql.Connection;

import connection.BddObject;
import connection.annotation.ColumnName;
import etu2070.annotation.restAPI;
import model.demande.Proforma;
import model.produit.Produit;

public class Fournisseur extends BddObject {
	
	String nom;
	@ColumnName("email")
	String mail;
	Proforma[] proformas;

	public Proforma[] getProformas() {
		return proformas;
	}
	public void setProformas(Proforma[] proformas) {
		this.proformas = proformas;
	}

	public void setNom( String nom ){
		this.nom = nom;
	}
	public String getNom(){
		return this.nom;
	}

	public void setMail( String nom ){
		this.mail = nom;
	}
	public String getMail(){
		return this.mail;
	}
	
	public Fournisseur() throws Exception {
		super();
		this.setTable("fournisseur");
		this.setPrimaryKeyName("id_fournisseur");
		this.setConnection("PostgreSQL");
	}

	public Fournisseur(String id) throws Exception {
		this();
		this.setId(id);
	}

	public Fournisseur getFournisseur(String id, Connection connection) throws Exception {
		Fournisseur fournisseur = null;
		boolean connect = false;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			fournisseur = (Fournisseur) new Fournisseur(id).getById(connection);
			Proforma[] proformas = (Proforma[]) new Proforma().setFournisseur(fournisseur).findAll(connection, "date_proforma ASC");
			for (Proforma proforma : proformas) {
				Produit produit = new Produit();
				produit.setProforma(proforma);
				produit.setTable("v_proforma");
				proforma.setProduits((Produit[]) produit.findAll(connection, "nom"));
			}
			fournisseur.setProformas(proformas);
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return fournisseur;
	}

	public Graph createGraph() {
		Graph graph = new Graph();
		graph.setProformas(this.getProformas());
		return graph;
	}

}