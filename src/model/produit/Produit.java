package model.produit;

import connection.BddObject;

public class Produit extends BddObject {

    String nom;
    String reference;
    String unite;

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

    public Produit() throws Exception {
        super();
        this.setTable("produit");
        this.setFunctionPK("nextval('s_produit')");
        this.setCountPK(6);
        this.setPrefix("PRO");
        this.setPrimaryKeyName("id_produit");
        this.setConnection("PostgreSQL");
    }

} 