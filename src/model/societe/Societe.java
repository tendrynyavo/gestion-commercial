package model.societe;

import connection.BddObject;
import connection.annotation.ColumnName;

public class Societe extends BddObject {
    @ColumnName("nom_societe")
    String nom;
    String email;
    @ColumnName("mot_de_passe")
    String motDePasse;

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Societe() throws Exception {
        super();
        this.setTable("societe");
        this.setFunctionPK("nextval('s_societe')");
        this.setCountPK(6);
        this.setPrefix("SCT");
        this.setConnection("PostgreSQL");
        this.setPrimaryKeyName("id_societe");
    }

    public Societe(String idsociete) throws Exception {
        this();
        this.setId(idsociete);
    }
}
