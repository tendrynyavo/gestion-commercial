package model.departement;

import model.demande.*;
import model.produit.*;
import java.sql.*;
import connection.*;

import connection.annotation.ColumnName;

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

	Bon bon;

	// Proforma[] proformas;

	// public void setProformas( Proforma[] pd ){
	// 	this.proformas = pd;
	// }
	// public Proforma[] getProformas(){
	// 	return this.proformas;
	// }

	// public Fournisseur() throws Exception{
	// 	init();
	// }

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
	
	public void setBon(Bon bon){
		System.out.println("okey tafiditra ato (1)");
		this.bon = bon;
	}
	public Bon getBon(){
		return this.bon;
	}

	public void addToBon(Produit produit) throws Exception{
		if( this.getBon() == null )	this.setBon( new Bon() );
		this.getBon().addProduct( produit );
	}

	public int getFournisseur(Fournisseur[] fs , Fournisseur f){
		int i = 0;
		for( Fournisseur fo : fs ){
			if( fo.getId() == f.getId() ) return i;
			i++;
		}
		return -1;
	}

	public void sendCommande( Connection connection ) throws Exception{
		if( this.getBon() == null ) return;
		this.getBon().setFournisseur( this.getId() );
		this.getBon().finalizeProducts();
		this.getBon().setCreation( Date.valueOf(java.time.LocalDate.now()) );
		this.getBon().setStatus(0);
		this.getBon().save(connection);
	}

	void init() throws Exception{
		this.setTable("fournisseur");
		this.setCountPK(7);
		this.setFunctionPK("nextval('s_fournisseur')");
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_fournisseur");
		this.setPrefix("FOU");
  }
	public Fournisseur() throws Exception {
		super();
		init();
    
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
			fournisseur.setProformas((Proforma[]) new Proforma().setFournisseur(fournisseur).findAll(connection, "date_proforma ASC"));
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return fournisseur;
	}

}