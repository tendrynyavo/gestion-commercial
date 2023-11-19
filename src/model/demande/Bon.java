package model.demande;

import java.sql.Connection;
import java.sql.Date;
import model.departement.*;
import model.produit.*;

public class Bon{
	
	Date creation, livraison;
	Integer status;
	String paiement;
	Double avance;
	Fournisseur fournisseur;

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

	public void generateBons() throws Exception{
		Connection connection = null;
		Produit[] produits = new Produit().getProduitGroup(connection);
	}

}