package model.demande;

import java.sql.Date;
import model.produit.*;

public class Proforma{
	
	Date date;
	Produit[] produits;

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
}