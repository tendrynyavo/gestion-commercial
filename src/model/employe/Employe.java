package model.employe;

import java.sql.Connection;
import java.sql.Date;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.departement.Departement;
import model.societe.Societe;

public class Employe extends BddObject {

    String nom;
    String prenom;
    String telephone;
    String genre;
    String password;
    @ColumnName("date_naissance")
    Date dateNaissance;
    String email;
    Fonction fonction;
    Departement departement;

    public Fonction getFonction() {
        return fonction;
    }

    public void setFonction(Fonction fonction) {
        this.fonction = fonction;
    }

    public Departement getDepartement() {
        return departement;
    }

    public void setDepartement(Departement departement) {
        this.departement = departement;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getTelephone() {
        return telephone;
    }

    public String getGenre() {
        return genre;
    }

    public String getPassword() {
        return password;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public String getEmail() {
        return email;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNomPrenom() {
        return this.getNom() + " " + this.getPrenom();
    }

    public Employe() throws Exception {
        super();
        this.setTable("employe");
        this.setFunctionPK("nextval('s_employe')");
        this.setCountPK(6);
        this.setPrefix("EMP");
        this.setConnection("PostgreSQL");
        this.setPrimaryKeyName("id_employe");
    }

    public static Employe login(String nom, String password) throws Exception {
        Employe employe = new Employe();
        employe.setNom(nom);
        employe.setPassword(password);
        Employe[] employes = (Employe[]) employe.findAll(null);
        if (employes.length == 0)
            throw new Exception("Nom ou mot de passe incorecte");
        return employes[0];
    }

    public static void main(String[] args) throws Exception {
        Employe employe = Employe.login("John", "password1");
        System.out.println(employe.getSociete().getNom());
    }

    public Societe getSociete() throws Exception {
        Societe s = new Societe();
        try (Connection connection = this.getConnection()) {
            String sql = "select * from v_societe where id_employe = '%s'";
            String sql2 = String.format(sql, this.getId());
            System.out.println(sql2);
            s = (Societe) new Societe().getData(sql2, connection)[0];
        } catch (Exception e) {
            throw e;
        }
        return s;
    }

}
