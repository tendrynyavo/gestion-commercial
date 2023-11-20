package model.demande;

import java.sql.Connection;
import java.sql.Date;
import model.departement.*;
import model.produit.*;
import model.validation.Validation;

import java.util.ArrayList;

import connection.Bdd;
import connection.BddObject;
import connection.annotation.*;

public class Bon extends Validation {
	
	@ColumnName("date_commande")
	Date creation;
	@ColumnName("date_livraison")
	Date livraison;
	@ColumnName("mode_paiment")
	String paiement;
	Double avance;
	@ColumnName("id_fournisseur")
	String fournisseur;
	String nom;
	String email;

	ArrayList<Produit> ps;
	Produit[] produits;

	// public void setMode( String paiement ){
	// 	this.setPaiement(paiement);
	// }
	// public void setLivraison(String a){
	// 	this.setLivraison(Date.valueOf(a));
	// }
	// public void setAvance(String avance){
	// 	this.setAvance(Double.parseDouble(avance));
	// }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

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

	public void setLivraison(String creation){
		this.setLivraison(Date.valueOf(creation));
	}
	public Date getLivraison(){
		return this.livraison;
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
	public void setAvance(String avance){
		this.setAvance(Double.parseDouble(avance));
	}
	public Double getAvance(){
		return this.avance;
	}

	public void setFournisseur(String fournisseur){
		this.fournisseur = fournisseur;
	}
	public String getFournisseur(){
		return this.fournisseur;
	}

	public ArrayList<Produit> getSomeProducts(){
		return this.ps;
	}

	public ArrayList<Produit> getPs(){
		return this.getSomeProducts();
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
		

		Connection connection = this.getConnection();
		
		try{

			// Produit[] produits = new Produit().getProduitGroup(connection, "15");
			Produit[] produits = new Produit().getProduits(connection, "15");
			Fournisseur[] fournisseurs = (Fournisseur[]) new Fournisseur().findAll(connection, null); // Maka ny fournisseur rehetra
			Proforma[] proformas = new Proforma().getProformas(connection, fournisseurs ); // Eto no maka ny proforma an'ny Fournisseur iray

			for( Produit produit : produits ){
				
				Proforma proforma = Proforma.moinDisant( proformas, produit );
				Fournisseur f = proforma.getFournisseur();
				int index = f.getFournisseur(fournisseurs, f);
				if(index >= 0) {
					fournisseurs[index].addToBon( produit );
				}
			}

			for( int i = 0; i < fournisseurs.length ; i++ ){
				fournisseurs[i].sendCommande( connection );
			}
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			// e.printStackTrace();
			throw e;
		}finally{
			connection.close();
		}
	}

	public void save(Connection connection) throws Exception{
		
		// Inona no tokony ataoko ato
		// Sauvena any anatiny ilay izy
		Produit[] ps = this.getProduits();
		this.setProduits(null);
		this.insert(connection);
		String id = this.getId();

		for( Produit p : ps ){
			p.setNom(null);
			p.setReference(null);
			p.setUnite(null);
			p.setStatus(null);
			p.setQuantite((Double)null);
			p.setBesoin(null);
			p.setId(null);
			p.setTable("detail_commande");
			p.setSerial(false);
			p.setCommande(id);
			p.insert(connection);
		}
		// Boucleko ilay produits rehetra de inserena ilay izy
	}

	void init() throws Exception{
		this.setTable("bon_de_commande");
		this.setPrefix("BON");
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_commande");
		this.setFunctionPK("nextval('s_bon')");
		this.setCountPK(7);
	}


	public double getMontant() throws Exception{
		double montant = 0;
		for( Produit p : this.getProduits() ) montant = montant + p.getPrixTTC();
		return montant;
	}

	public double getTVATotal() throws Exception{
		double tva = 0;
		for( Produit p : this.getProduits() ) tva = tva + p.getPrix();
		return (20 * tva) / 100.0;
	}

	// Inona daholo ny atao ato zao

	public void modify( String mode, String date, String avance, String id ) throws Exception{
		Connection connection = this.getConnection();
		try{
			Bon bon = new Bon();
			bon.setId(id);

			bon = (Bon) bon.getById(connection);
			bon.setPaiement(mode);
			bon.setLivraison(date);
			bon.setAvance(avance);
			bon.update(connection);
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			throw e;
		}finally{
			connection.close();
		}
	}
	/// mandeha aloha ny premiere validation
	// Rehefa premiere validation de lasa status 10

	Bon updateStatus(Connection connection, String status, String idBon) throws Exception{
		Bon bon = new Bon();
		bon.setId(idBon);
		bon = (Bon) bon.getById(connection);
		bon.setStatus(Integer.parseInt(status));
		bon.update(connection);
		return bon;
	}

	public void passFirstValidation( String idBon ) throws Exception{
		
		Connection connection = this.getConnection();
		try{
			this.updateStatus(connection, "10", idBon);
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			throw e;
		}finally{
			connection.close();
		}
	}

	public void passSecondValidation(String idBon) throws Exception{
		Connection connection = this.getConnection();
		try{
			this.updateStatus(connection, "20", idBon);
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			throw e;
		}finally{
			connection.close();
		}	
	}

	public void setDetails( Connection connection) throws Exception{
		Produit produit = new Produit();
		produit.setTable(String.format("v_detail_commande where id_commande = '%s'", this.getId()));
		Produit[] produits = (Produit[]) produit.findAll(connection, null);
		this.setProduits(produits);
	}


	// Ato izy no mila tenenina hoe alaivo daholo ny detail commande rehetra
	public void passThirdValidation(String idBon) throws Exception{
		Connection connection = this.getConnection();
		try{
			Bon bon = this.updateStatus(connection, "25", idBon);
			bon.setDetails(connection);
			for( Produit p : bon.getProduits() ){
				p.setStatus(20);
				p.setTable("demande");
				p.setPrimaryKeyName("id");
				p.setPrix((Double)null);
				p.setTva((Double)null);
				p.setId(p.getDemande());
				p.setDemande(null);
				p.setNom(null);
				p.setReference(null);
				p.setUnite(null);
				p.setCommande(null);
				p.update(connection);
			}
			connection.commit();
		}catch(Exception e){
			connection.rollback();
			throw e;
		}finally{
			connection.close();
		}	
	}

	public Bon getBonDeCommande(String id, Connection connection) throws Exception {
        boolean connect = false;
        Bon bon = null;
        try {
			if (id == null) return null;
			if (connection == null) {
				connection = this.getConnection();
                connect = true;
            }
            bon = (Bon) ((BddObject) new Bon().setTable("v_bon_commande_fournisseur")).setId(id).getById(connection);
			Produit produit = new Produit();
            produit.setCommande(bon.getId());
            produit.setTable("v_detail_commande");
            if (bon != null) {
				bon.setProduits((Produit[]) produit.findAll(connection, "nom"));
            }
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return bon;
    }

}