package model.proforma;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

import connection.BddObject;
import connection.annotation.ColumnName;
import model.departement.Fournisseur;
import model.produit.Produit;
import model.societe.Societe;

public class Demande extends BddObject {
    Societe societe;
    Fournisseur fournisseur;
    @ColumnName("date_demande")
    Date dateDemande;
    Produit[] produits;

    public Societe getSociete() {
        return societe;
    }

    public void setSociete(Societe societe) {
        this.societe = societe;
    }

    public Fournisseur getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(Fournisseur fournisseur) {
        this.fournisseur = fournisseur;
    }

    public Date getDateDemande() {
        return dateDemande;
    }

    public void setDateDemande(Date dateDemande) {
        this.dateDemande = dateDemande;
    }

    public Produit[] getProduits() {
        return produits;
    }

    public void setProduits(Produit[] produits) {
        this.produits = produits;
    }

    public Demande() throws Exception {
        super();
        this.setTable("demande_proforma");
        this.setPrimaryKeyName("id_demande_proforma");
        this.setFunctionPK("nextval('s_demande_proforma')");
        this.setCountPK(6);
        this.setPrefix("DPF");
        this.setConnection("PostgreSQL");
    }

    public Demande getDemande(String id, Connection connection) throws Exception {
        Demande d = new Demande();
        boolean connect = false;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            Produit[] p = new Produit[0];
            d = (Demande) new Demande().setId(id).getById(connection);
            d.setProduits(p);
            String sql = "select * from v_demande_proforma where id_demande_proforma = '%s' and etat=0";
            String sql2 = String.format(sql, id);
            System.out.println(sql2);
            Produit[] prd = (Produit[]) new Produit().getData(sql2, connection);
            if (prd.length > 0) {
                d.setProduits(prd);
            }
            System.out.println(d.getProduits().length);
        } catch (Exception e) {
            throw e;
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return d;
    }

    public Demande getDemandeValide(String id, Connection connection) throws Exception {
        Demande d = new Demande();
        boolean connect = false;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            Produit[] p = new Produit[0];
            d = (Demande) new Demande().setId(id).getById(connection);
            d.setProduits(p);
            String sql = "select * from v_demande_proforma where id_demande_proforma = '%s' and etat=5";
            String sql2 = String.format(sql, id);
            System.out.println(sql2);
            Produit[] prd = (Produit[]) new Produit().getData(sql2, connection);
            if (prd.length > 0) {
                d.setProduits(prd);
            }
            System.out.println(d.getProduits().length);
        } catch (Exception e) {
            throw e;
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return d;
    }

    public void ajouterProduit(Produit produit, Connection connection) throws Exception {
        boolean connect = false;
        PreparedStatement st = null;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            String requete = "insert into detail_demande_proforma values(default,?,?,?,0)";
            st = connection.prepareStatement(requete);
            st.setString(1, this.getId());
            st.setString(2, produit.getId());
            st.setDouble(3, produit.getQuantite());
            st.execute();
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

    public void ajouterProduit(String id, String article, String quantite, Connection connection) throws Exception {
        boolean connect = false;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            Demande demande = (Demande) new Demande().setId(id).getById(connection);
            Produit produit = new Produit();
            produit.setId(article);
            produit.setQuantite(quantite);
            demande.ajouterProduit(produit, connection);
            connection.commit();
        } catch (Exception e) {
            connection.rollback();
            throw e;
        } finally {
            if (connect) {
                connection.close();
            }
        }
    }

    public void validerProduit(String idarticle, double qtt, Connection connection) throws Exception {
        boolean connect = false;
        PreparedStatement st = null;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            String requete = "update detail_demande_proforma set etat=5 where id_demande_proforma=? and id_produit=? and quantite=?";
            st = connection.prepareStatement(requete);
            st.setString(1, this.getId());
            st.setString(2, idarticle);
            st.setDouble(3, qtt);
            st.execute();
            connection.commit();
        } catch (Exception e) {
            connection.rollback();
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

    public void validerProduitProforma(String idarticle, String qtt, Connection connection) throws Exception {
        boolean connect = false;
        PreparedStatement st = null;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            String requete = "update detail_demande_proforma set etat=10 where id_demande_proforma=? and id_produit=? and quantite=?";
            st = connection.prepareStatement(requete);
            st.setString(1, this.getId());
            st.setString(2, idarticle);
            st.setDouble(3, Double.parseDouble(qtt));
            st.execute();
            connection.commit();
        } catch (Exception e) {
            connection.rollback();
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

}
