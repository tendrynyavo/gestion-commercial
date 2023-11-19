package model.demande;

import java.sql.Connection;
import java.sql.Date;
import model.departement.*;
import model.produit.*;
import java.util.ArrayList;
import connection.BddObject;

public class Bon extends BddObject{
	
	Date creation, livraison;
	Integer status;
	String paiement;
	Double avance;
	Fournisseur fournisseur;

	ArrayList<Produit> ps;
	Produit[] produits;

	public Bon() throws Exception{
		init();
	}

	public void setProduits(Produit[] ps){
		this.produits = ps;
	}
	public Produit[] getProduits(){
		return this.produits;
	}

	public void setCreation(Date creation){
		this.creation = creation;
	}
	public Date getCreation(){
		return this.creation;
	}

	public void setLivraison(Date creation){
		this.livraison = creation;
	}
	public Date getLivraison(){
		return this.livraison;
	}

	public void setStatus(Integer status){
		this.status = status;
	}
	public Integer getStatus(){
		return this.status;
	}


	public void setPaiement(String paiement){
		this.paiement = paiement;
	}
	public String getPaiement(){
		return this.paiement;
	}

	public void setAvance(Double avance){
		this.avance = avance;
	}
	public Double getAvance(){
		return this.avance;
	}

	public void setFournisseur(Fournisseur fournisseur){
		this.fournisseur = fournisseur;
	}
	public Fournisseur getFournisseur(){
		return this.fournisseur;
	}

	public ArrayList<Produit> getSomeProducts(){
		return this.ps;
	}

	public void addProduct( Produit produit ){
		if( this.getSomeProducts() == null ) this.ps = new ArrayList<Produit>();
		this.getSomeProducts().add(produit);
	}

	public void finalizeProducts(){
		this.setProduits( this.getSomeProducts().toArray( new Produit[ this.getSomeProducts().size() ] ) );
		this.ps = null;
	}

	public void generateBons() throws Exception{
		

		Connection connection = null;
		
		Produit[] produits = new Produit().getProduitGroup(connection);
		Proforma[] proformas = null;
		Fournisseur[] fournisseurs = null;
		try{

			for( Produit produit : produits ){
				Proforma proforma = Proforma.moinDisant( proformas, produit );
				Fournisseur f = new Fournisseur().getFournisseur( fournisseurs, proforma.getFournisseur() );
				f.addToBon( produit );
			}

			for( Fournisseur f : fournisseurs ) f.sendCommande( connection );
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			e.printStackTrace();
			throw e;
		}finally{
			connection.close();
		}
	}

	void init() throws Exception{
		this.setTable("bon_de_commande");
		this.setPrefix("PRE");
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_commande");
		this.setFunctionPK("s_bon");
		this.setCountPK(7);
	}

	// Inona daholo ny atao ato zao
	
}