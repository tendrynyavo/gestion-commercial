package model.departement;

import connection.BddObject;

public class Departement extends BddObject {

    String nom;

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Departement() throws Exception {
        super();
        this.setTable("departement");
        this.setFunctionPK("nextval('s_departement')");
        this.setCountPK(7);
        this.setPrefix("DEPT");
        this.setConnection("PostgreSQL");
        this.setPrimaryKeyName("id_departement");
    }

}