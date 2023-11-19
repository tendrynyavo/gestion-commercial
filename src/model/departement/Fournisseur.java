package model.departement;

import model.demande.*;
import model.produit.*;
import java.sql.*;
import connection.*;

public class Fournisseur extends BddObject{
	
	String nom;
	String mail;
	Bon bon;

	public Fournisseur() throws Exception{

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
	
	public void setBon(Bon bon){
		this.bon = bon;
	}
	public Bon getBon(){
		return this.bon;
	}

	public void addToBon(Produit produit) throws Exception{
		if( this.getBon() == null )	this.setBon( new Bon() );
		this.getBon().addProduct( produit );
	}

	public Fournisseur getFournisseur(Fournisseur[] fs , Fournisseur f){
		for( Fournisseur fo : fs ){
			if( fo.getId() == f.getId() ){
				return fo;
			}
		}
		return null;
	}

	public void sendCommande( Connection connection ) throws Exception{
		this.getBon().setFournisseur( this );
		this.getBon().finalizeProducts();
		this.getBon().setCreation( Date.valueOf(java.time.LocalDate.now()) );
		Produit[] ps = this.getBon().getProduits();
		this.getBon().setProduits(null);
		this.getBon().setStatus(10);
		// this.getBon().insert(connection);
	}

}