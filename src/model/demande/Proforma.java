package model.demande;

import java.sql.Connection;
import java.sql.Date;
import model.produit.*;

import connection.*;
import model.departement.*;
import connection.annotation.*;

public class Proforma extends BddObject{
	
	@ColumnName("date_proforma")
	Date date;
	Produit[] produits;
	@ColumnName("id_fournisseur")
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
				System.out.println("jajajajajajaj");
				if( p2.getPrix() >= p.getPrix() ){
					best = pFs[i];
					produit.setPrix(p2.getPrix());
					produit.setTva(p2.getTva());
				}
			}
		}
		// Produit a = best.getProduit(produit);
		// System.out.println("avy ato amin'ny proformat :::: prix == " + produit.getPrix());
		// System.out.println("avy ato amin'ny proformat :::: tva == " + produit.getTva());
		return best;
	}

	public Proforma() throws Exception{
		init();
	}

	void init() throws Exception{
		this.setTable("proforma");
		this.setCountPK(7);
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_proforma");
		this.setFunctionPK("nextval('s_proforma')");
		this.setPrefix("PRE");
	}

	void setProduits(Connection connection) throws Exception{
		Produit p = new Produit();
		p.setTable(String.format("v_detail_proforma_produit where id_proforma = '%s'", this.getId()) );
		Produit[] ps = (Produit[]) p.findAll(connection, null);
		this.setProduits(ps);
	}

	public Proforma[] getProformas( Connection connection, Fournisseur[] fournisseurs ) throws Exception{
		
		Proforma[] pfs = new Proforma[ fournisseurs.length ];
		int i = 0;
		String sql = "select * from proforma where id_fournisseur = '%s' order by date_proforma desc limit 1";
		for( Fournisseur fournisseur : fournisseurs ){
			String sql2 = String.format(sql , fournisseur.getId());
			// System.out.println(sql2);
			Proforma p = (Proforma) this.getData( sql2, connection )[0];
			p.setFournisseur( fournisseur );
			p.setProduits(connection);
			pfs[i] = p;
			i++;
		}
		return pfs;
	}


}