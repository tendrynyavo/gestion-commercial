package model.demande;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connection.BddObject;
import connection.annotation.ColumnName;
import model.departement.Fournisseur;
import model.produit.*;
import model.societe.Societe;

public class Proforma extends BddObject {

	@ColumnName("date_proforma")
	Date date;
	Produit[] produits;
	@ColumnName("id_fournisseur")
	Fournisseur fournisseur;
	Societe societe;

	public Fournisseur getFournisseur() {
		return fournisseur;
	}

	public Proforma setFournisseur(Fournisseur fournisseur) {
		this.fournisseur = fournisseur;
		return this;
	}

	public Societe getSociete() {
		return societe;
	}

	public void setSociete(Societe societe) {
		this.societe = societe;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getDate() {
		return this.date;
	}

	public void setProduits(Produit[] produits) {
		this.produits = produits;
	}

	public Produit[] getProduits() {
		return this.produits;
	}

	public Produit getProduit(Produit produit) throws Exception {
		for (Produit p : this.getProduits()) {
			if (p.equals(produit))
				return p;
		}
		return null;
	}

	// public void setFournisseur(Fournisseur fs){
	// this.fournisseur = fs;
	// }
	// public Fournisseur getFournisseur(){
	// return this.fournisseur;
	// }

	public static Proforma moinDisant(Proforma[] pFs, Produit produit) throws Exception {
		Proforma best = pFs[0];
		System.out.println(produit.getNom());
		for (int i = 0; i < pFs.length; i++) {
			Produit p = pFs[i].getProduit(produit);
			Produit p2 = best.getProduit(produit);
			System.out.println("produit === " + produit.getNom());
			System.out.println("Proforma acitfs === " + pFs[i].getId());
			System.out.println("Proforma nows === " + best.getId());
			if (p != null) {
				if (p2 == null || p2.getPrix() >= p.getPrix()) {
					best = pFs[i];
					produit.setPrix(p.getPrix());
					produit.setTva(p.getTva());
				}
			}
		}
		// Produit a = best.getProduit(produit);
		// System.out.println("avy ato amin'ny proformat :::: prix == " +
		// produit.getPrix());
		// System.out.println("avy ato amin'ny proformat :::: tva == " +
		// produit.getTva());
		return best;
	}

	public Proforma() throws Exception {
		super();
		init();
	}

	public Proforma(String id) throws Exception {
		this();
		this.setId(id);
	}

	public Proforma(String id, Date date, Fournisseur f, Produit[] produit) throws Exception {
		this();
		this.setId(id);
		this.setDate(date);
		this.setFournisseur(f);
		this.setProduits(produit);
	}

	void init() throws Exception {
		this.setTable("proforma");
		this.setCountPK(7);
		this.setConnection("PostgreSQL");
		this.setPrimaryKeyName("id_proforma");
		this.setFunctionPK("nextval('s_proforma')");
		this.setPrefix("PRE");
	}

	void setProduits(Connection connection) throws Exception {
		Produit p = new Produit();
		p.setTable(String.format("v_detail_proforma_produit where id_proforma = '%s'", this.getId()));
		Produit[] ps = (Produit[]) p.findAll(connection, null);
		this.setProduits(ps);
	}

	public Proforma[] getProformas(Connection connection, Fournisseur[] fournisseurs) throws Exception {

		Proforma[] pfs = new Proforma[fournisseurs.length];
		int i = 0;
		String sql = "select * from proforma where id_fournisseur = '%s' order by date_proforma desc limit 1";
		for (Fournisseur fournisseur : fournisseurs) {
			String sql2 = String.format(sql, fournisseur.getId());
			// System.out.println(sql2);
			Proforma p = (Proforma) this.getData(sql2, connection)[0];
			p.setFournisseur(fournisseur);
			p.setProduits(connection);
			pfs[i] = p;
			i++;
		}
		return pfs;
	}

	// public Proforma() throws Exception {
	// super();
	// this.setCountPK(7);
	// this.setFunctionPK("nextval('s_proforma')");
	// this.setPrefix("PROF");
	// this.setTable("proforma");
	// this.setConnection("PostgreSQL");
	// this.setPrimaryKeyName("id_proforma");
	// }

	public void ajouterProduit(String id, String article, String quantite, String prixUnitaire, String tva)
			throws Exception {
		try (Connection connection = this.getConnection()) {
			Proforma proforma = (Proforma) new Proforma().setId(id);
			Produit produit = new Produit();
			produit.setId(article);
			produit.setQuantite(quantite);
			produit.setPrix(prixUnitaire);
			produit.setTva(tva);
			proforma.ajouterProduit(produit, connection);
			connection.commit();
		}
	}

	public void ajouterProduit(Produit produit, Connection connection) throws Exception {
		produit.setProforma(this);
		produit.setTable("detail_proforma");
		produit.setSerial(false);
		produit.insert(connection);
	}

	public void ajouterProduit(String id, String article, String quantite) throws Exception {
		try (Connection connection = this.getConnection()) {
			Proforma proforma = this.getProforma(id, connection);
			Produit produit = new Produit();
			produit.setId(article);
			produit.setQuantite(quantite);
			proforma.ajouterProduit(produit, connection);
			connection.commit();
		}
	}

	public Proforma getProforma(String id, Connection connection) throws Exception {
		boolean connect = false;
		Proforma proforma = null;
		try {
			if (id == null)
				return null;
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			proforma = (Proforma) new Proforma().setId(id).getById(connection);
			Produit produit = new Produit();
			produit.setProforma(proforma);
			produit.setTable("v_proforma");
			if (proforma != null) {
				proforma.setProduits((Produit[]) produit.findAll(connection, "nom"));
			}
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return proforma;
	}

	public Proforma insertion(String idsociete, Connection connection) throws Exception {
		boolean connect = false;
		PreparedStatement st = null;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			this.setId(this.construirePK(connection));
			String requete = "insert into proforma values(?,?,?,?)";
			st = connection.prepareStatement(requete);
			st.setString(1, this.getId());
			st.setDate(2, this.getDate());
			st.setString(3, this.getFournisseur().getId());
			st.setString(4, idsociete);
			st.execute();
			connection.commit();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				st.close();
			}
			if (connect) {
				connection.close();
			}
		}
		return this;
	}

	public void insertionDetail(String societe, String quantite, String produit, String pu,
			String tva, Connection connection) throws Exception {
		boolean connect = false;
		PreparedStatement st = null;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			String requete = "insert into detail_proforma values(default,?,?,?,?,?)";
			st = connection.prepareStatement(requete);
			st.setString(1, produit);
			st.setString(2, this.getId());
			st.setDouble(3, Double.parseDouble(quantite));
			st.setDouble(4, Double.parseDouble(pu));
			st.setDouble(5, Double.parseDouble(tva));
			st.execute();
			connection.commit();
			this.setProduits(this.getProduits());
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				st.close();
			}
			if (connect) {
				connection.close();
			}
		}
	}

	public String construirePK(Connection connection) throws Exception {
		String primarykey = "";
		boolean connect = false;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("select nextval('s_proforma')");
			int seq = 0;
			while (rs.next()) {
				seq = rs.getInt(1);

			}
			primarykey = "PRF" + completerZero(6, seq);

		} catch (Exception e) {
			throw e;
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return primarykey;
	}

	public String completerZero(int longPK, int seq) {
		String valiny = "";
		int sequence = String.valueOf(seq).length();
		while (valiny.length() + 3 + sequence < longPK) {
			valiny += "0";
		}
		valiny += String.valueOf(seq);
		return valiny;
	}

	public Produit[] getProduits(String idProforma, Connection connection) throws Exception {
		Produit[] pr = new Produit[0];
		boolean connect = false;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			String sql = "select * from v_detail_proforma where id_proforma = '%s'";
			String sql2 = String.format(sql, idProforma);
			Produit[] prd = (Produit[]) new Produit().getData(sql2, connection);
			if (prd.length > 0) {
				pr = prd;
			}
			System.out.println(pr.length);
		} catch (Exception e) {
			throw e;
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return pr;
	}

}