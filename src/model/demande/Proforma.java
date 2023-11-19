package model.demande;

import java.sql.Date;
import model.produit.*;

import connection.*;
import model.departement.*;

public class Proforma extends BddObject{
	
	Date date;
	Produit[] produits;
	Fournisseur fournisseur;

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

	public Produit getProduit( Produit produit ) throws Exception{
		for( Produit p : this.getProduits() ){
			if( p.equals(produit) ) return p;
		}
		return null;
	}

	public void setFournisseur(Fournisseur fs){
		this.fournisseur = fs;
	}
	public Fournisseur getFournisseur(){
		return this.fournisseur;
	}

	public static Proforma moinDisant( Proforma[] pFs, Produit produit ) throws Exception{
		Proforma best = pFs[0];
		for( int i = 0 ; i < pFs.length ; i++ ){
			Produit p = pFs[i].getProduit( produit );
			if( p != null ){
				Produit p2 = best.getProduit(produit);
				if( p2.getPrix() >= p.getPrix() ){
					best = pFs[i];
				}
			}
		}
		return best;
	}

	public Proforma() throws Exception{

	}

	void init() throws Exception{
		this.setTable("proforma");
		this.setCountPK(7);
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_proforma");
		this.setFunctionPK("s_proforma");
		this.setPrefix("PRE");
	}

}