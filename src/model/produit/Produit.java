package model.produit;

import connection.BddObject;
import connection.annotation.ColumnName;
import model.besoin.Besoin;

public class Produit extends BddObject {

    String nom;
    String reference;
    String unite;
    Double quantite;
    Integer status;
    Besoin besoin;
    @ColumnName("id_demande")
    String demande;

    public String getDemande() {
        return demande;
    }

    public void setDemande(String demande) {
        this.demande = demande;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Besoin getBesoin() {
        return besoin;
    }

    public void setBesoin(Besoin besoin) {
        this.besoin = besoin;
    }

    public Double getQuantite() {
        return quantite;
    }

    public void setQuantite(Double quantite) {
        this.quantite = quantite;
    }

    public void setQuantite(String quantite) {
        this.setQuantite(Double.parseDouble(quantite));
    }

    public String getNom() {
        return nom;
    }

    public String getReference() {
        return reference;
    }

    public String getUnite() {
        return unite;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getStringStatus() {
        String status = null;
        switch (this.getStatus()) {
            case 20:
                status = "Valide";
                break;

            case 10:
                status = "Post-valide";
                break;

            case 0:
                status = "En attente";
                break;
        
            default:
                status = "";
                break;
        }
        return status;
    }

    public Produit() throws Exception {
        super();
        this.setTable("produit");
        this.setFunctionPK("nextval('s_produit')");
        this.setCountPK(6);
        this.setPrefix("PRO");
        this.setPrimaryKeyName("id_produit");
        this.setConnection("PostgreSQL");
    }

    public void valider() throws Exception {
        this.setPrimaryKeyName("id");
        this.setTable("demande");
        this.setStatus(10);
        this.update(null);
    }

    public static Produit[] getProduitGroup() throws Exception {
        Produit produit = new Produit();
        produit.setTable("v_liste_groupe");
        return (Produit[]) produit.findAll(null);
    }

}