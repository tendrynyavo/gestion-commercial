package model.demande;

import java.sql.Connection;
import java.sql.Date;
import model.departement.*;
import model.produit.*;
import java.util.ArrayList;
import connection.BddObject;
import connection.annotation.*;

public class Bon extends BddObject{
	
	@ColumnName("date_commande")
	Date creation;
	@ColumnName("date_livraison")
	Date livraison;
	Integer status;
	@ColumnName("mode_paiment")
	String paiement;
	Double avance;
	@ColumnName("id_fournisseur")
	String fournisseur;

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
				// System.out.println("produit prix == " + produit.getPrix());
				// System.out.println("produit tva == " + produit.getTva());
				if(index >= 0) {
					System.out.println("index is ::: " + index );
					fournisseurs[index].addToBon( produit );
				}
			}

			for( int i = 0; i < fournisseurs.length ; i++ ){
				fournisseurs[i].sendCommande( connection );
				// Adino ny ni-inserer an'ilay detail 
				// Andao atao izany zao
				// Mila fantatra aloha hoe avy aiza ilay izy
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

	// Inona daholo ny atao ato zao
	
}