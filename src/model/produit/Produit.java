package model.produit;

import connection.BddObject;
import connection.Column;
import connection.annotation.ColumnName;
import model.besoin.Besoin;
import model.demande.Proforma;
import model.validation.Validation;

import java.math.RoundingMode;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.List;

public class Produit extends Validation {

    String nom;
    String reference;
    String unite;
    Double quantite;
    Besoin besoin;
    @ColumnName("id_demande")
    String demande;
    Proforma proforma;
    @ColumnName("prix_unitaire")
    Double prix;
    Double tva;
    @ColumnName("id_commande")
    String commande;

    public void setCommande(String commande){
        this.commande = commande;
    }
    public String getCommande(){
        return this.commande;
    }
    public Proforma getProforma() {
        return proforma;
    }

    public void setProforma(Proforma proforma) {
        this.proforma = proforma;

    }

    public double getTvaPrice(){
        return (this.getTva() * this.getPrix()) / 100.0 ;
    }
    public double getPrixTTC(){
        return this.getTvaPrice() + this.getPrix();
    }

    public void setPrix(Double prix){
        this.prix = prix;
    }

    public Double getMontant(){
        return this.getQuantite() * this.getPrixTTC();
    }

    public void setPrix(String prix){
        this.setPrix(Double.parseDouble(prix));
    }

    public Double getPrix(){
        return this.prix;
    }

    public void setTva( Double tva ){
        this.tva = tva;
    }

    public void setTva( String tva ){
        this.setTva(Double.parseDouble(tva));
    }

    public Double getTva(){
        return this.tva;
    }


    public String getDemande() {
        return demande;
    }

    public void setDemande(String demande) {
        this.demande = demande;
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

    public Produit() throws Exception {
        super();
        this.setTable("produit");
        this.setFunctionPK("nextval('s_produit')");
        this.setCountPK(6);
        this.setPrefix("PRO");
        this.setPrimaryKeyName("id_produit");
        this.setConnection("PostgreSQL");
    }

    public void postValider() throws Exception {
        this.setPrimaryKeyName("id");
        this.setTable("demande");
        this.setStatus(10);
        this.update(null);
    }

    public void valider() throws Exception {
        try (Connection connection = this.getConnection()) {
            try (Statement statement = connection.createStatement()) {
                String sql = String.format("UPDATE demande SET status = 15 WHERE id_produit = '%s' AND status = 10", this.getId());
                statement.executeUpdate(sql);
            }
            connection.commit();
        }
    }

    public static Produit[] getProduitGroup(String status, Connection connection) throws Exception {
        Produit produit = new Produit();
        produit.setTable(String.format("v_liste_groupe WHERE status = %s", status));
        return (Produit[]) ((connection == null) ? produit.findAll(null) : produit.findAll(connection, null));
    }

    public static Produit[] getProduits(Connection connection, String status) throws Exception {
        Produit produit = new Produit();
        produit.setTable(String.format("v_demande WHERE status = %s", status));
        return (Produit[]) produit.findAll(null);
    }

    public static Produit[] getProduitGroup(Connection connection, String status) throws Exception {
        Produit produit = new Produit();
        produit.setTable(String.format("v_liste_groupe WHERE status = %s", status));
        return (Produit[]) produit.findAll(connection, null);
    }

    public static Produit[] getProduitGroup(Connection connection) throws Exception {
        Produit produit = new Produit();
        produit.setTable("v_liste_groupe");
        return (Produit[]) produit.findAll(connection, null);
    }

    // @Override
    public boolean equals( Produit p ) throws Exception{
        return String.valueOf(p.getId()).equals( String.valueOf(this.getId()));
    }

    public static String format(double number) {
        DecimalFormat df = new DecimalFormat("#.##");
        df.setRoundingMode(RoundingMode.CEILING);
        return df.format(number);
    }

}