package model.departement;

import model.demande.*;
import java.sql.*;
import connection.*;

import connection.annotation.ColumnName;
import model.demande.Proforma;
import model.produit.Produit;
import model.proforma.Demande;
import model.proforma.Mail;
import model.societe.Societe;

public class Fournisseur extends BddObject {

	String nom;
	@ColumnName("email")
	String mail;
	@ColumnName("mot_de_passe")
	String motDePasse;
	Proforma[] proformas;

	public String getMotDePasse() {
		return motDePasse;
	}

	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}

	public Proforma[] getProformas() {
		return proformas;
	}

	public void setProformas(Proforma[] proformas) {
		this.proformas = proformas;
	}

	Bon bon;

	// Proforma[] proformas;

	// public void setProformas( Proforma[] pd ){
	// this.proformas = pd;
	// }
	// public Proforma[] getProformas(){
	// return this.proformas;
	// }

	// public Fournisseur() throws Exception{
	// init();
	// }

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getNom() {
		return this.nom;
	}

	public void setMail(String nom) {
		this.mail = nom;
	}

	public String getMail() {
		return this.mail;
	}

	public void setBon(Bon bon) {
		System.out.println("okey tafiditra ato (1)");
		this.bon = bon;
	}

	public Bon getBon() {
		return this.bon;
	}

	public void addToBon(Produit produit) throws Exception {
		if (this.getBon() == null)
			this.setBon(new Bon());
		this.getBon().addProduct(produit);
	}

	public int getFournisseur(Fournisseur[] fs, Fournisseur f) {
		int i = 0;
		for (Fournisseur fo : fs) {
			if (fo.getId().equals(f.getId()))
				return i;
			i++;
		}
		return -1;
	}

	public void sendCommande(Connection connection) throws Exception {
		if (this.getBon() == null)
			return;
		this.getBon().setFournisseur(this.getId());
		this.getBon().finalizeProducts();
		this.getBon().setCreation(Date.valueOf(java.time.LocalDate.now()));
		this.getBon().setStatus(0);
		this.getBon().save(connection);
	}

	void init() throws Exception {
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
			Proforma[] proformas = (Proforma[]) new Proforma().setFournisseur(fournisseur).findAll(connection,
					"date_proforma DESC");
			for (Proforma proforma : proformas) {
				Produit produit = new Produit();
				produit.setProforma(proforma);
				produit.setTable("v_proforma");
				proforma.setProduits((Produit[]) produit.findAll(connection, "nom"));
			}
			fournisseur.setProformas(proformas);
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return fournisseur;
	}

	public Graph createGraph() {
		Graph graph = new Graph();
		graph.setProformas(this.getProformas());
		return graph;
	}

	public Demande getLastDemande(Connection connection) throws Exception {
		Demande s = new Demande();
		boolean connect = false;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			String sql = "select * from demande_proforma where id_fournisseur = '%s' order by date_demande desc,id_demande_proforma desc limit 1";
			String sql2 = String.format(sql, this.getId());
			System.out.println(sql2);
			s = (Demande) new Demande().getData(sql2, connection)[0];
		} catch (Exception e) {
			throw e;
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return s;
	}

	public Demande[] getDemande(Connection connection) throws Exception {
		Demande[] demande = new Demande[0];
		boolean connect = false;
		try {
			if (connection == null) {
				connection = this.getConnection();
				connect = true;
			}
			String sql = "select * from demande_proforma where id_fournisseur = '%s'";
			String sql2 = String.format(sql, this.getId());
			System.out.println(sql2);
			Demande[] s = (Demande[]) new Demande().getData(sql2, connection);
			demande = new Demande[s.length];
			for (int i = 0; i < s.length; i++) {
				demande[i] = s[i].getDemande(s[i].getId(), connection);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (connect) {
				connection.close();
			}
		}
		return demande;
	}

	/*
	 * public static void main(String[] args) {
	 * try {
	 * Fournisseur f = new Fournisseur("FOUR001");
	 * Demande[] d = f.getDemande();
	 * for (int i = 0; i < d.length; i++) {
	 * System.out.println(d[i].getProduits().length);
	 * }
	 * } catch (Exception e) {
	 * e.printStackTrace();
	 * }
	 * 
	 * }
	 */

	public static Fournisseur login(String mail, String password) throws Exception {
		Fournisseur f = new Fournisseur();
		f.setMail(mail);
		f.setMotDePasse(password);
		Fournisseur[] fourn = (Fournisseur[]) f.findAll(null);
		if (fourn.length == 0)
			throw new Exception("Nom ou mot de passe incorecte");
		return fourn[0];
	}

	public double checkStock(String idarticle, Date date, Connection connection) throws Exception {
		double entree = this.getMouvement(idarticle, date, connection, "entree");
		double sortie = this.getMouvement(idarticle, date, connection, "sortie");
		return entree - sortie;
	}

	public double getMouvement(String idarticle, Date date, Connection con, String type) throws Exception {
		double qtt = 0;
		Statement st = null;
		ResultSet res = null;
		int co = 0;
		try {
			if (con == null) {
				con = this.getConnection();
				co = 1;
			}
			String requete = " select sum(quantite) as qtt from " + type + " where id_produit='" + idarticle
					+ "' and id_fournisseur='" + this.getId() + "' and date_mouvement<='" + date + "'";
			st = con.createStatement();
			res = st.executeQuery(requete);
			while (res.next()) {
				qtt = res.getDouble("qtt");
			}
		} catch (Exception ex) {
			throw ex;
		} finally {

			if (res != null) {
				res.close();
			}
			if (st != null) {
				st.close();
			}
			if (co == 1) {
				con.close();
			}
		}
		return qtt;
	}

	public Proforma getLastProforma(Connection con) throws Exception {
		Proforma p = new Proforma();
		Statement st = null;
		ResultSet res = null;
		int co = 0;
		try {
			if (con == null) {
				con = this.getConnection();
				co = 1;
			}
			String requete = "select * from proforma where date_proforma=(select max(date_proforma) from proforma where id_fournisseur='"
					+ this.getId() + "') and id_fournisseur='" + this.getId() + "'";
			st = con.createStatement();
			res = st.executeQuery(requete);
			System.out.println(requete);
			while (res.next()) {
				Fournisseur f = (Fournisseur) new Fournisseur(res.getString("id_fournisseur")).getById(con);
				p = new Proforma(res.getString("id_proforma"), res.getDate("date_proforma"), f,
						p.getProduits(res.getString("id_proforma"), con));
				p.setSociete((Societe) new Societe(res.getString("id_societe")).getById(con));
			}
		} catch (Exception ex) {
			throw ex;
		} finally {

			if (res != null) {
				res.close();
			}
			if (st != null) {
				st.close();
			}
			if (co == 1) {
				con.close();
			}
		}
		return p;
	}

	public static void main(String[] args) {
		try {
			Fournisseur f = new Fournisseur("FOUR001");
			Proforma p = f.getLastProforma(null);
			Mail.creerExcel(p);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}