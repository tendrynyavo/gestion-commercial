package model.graph;

import model.produit.Produit;

public class Graph {

    Produit[] produits;
    Produit[] produitsBon;

    public Produit[] getProduitsBon() {
        return produitsBon;
    }

    public void setProduitsBon(Produit[] produitsBon) {
        this.produitsBon = produitsBon;
    }
    
    public void setProduits(Produit[] produits) {
        this.produits = produits;
    }

    public Produit[] getProduits() {
        return produits;
    }

    public String getLabels() {
        if (this.getProduits().length == 0) return "";
        StringBuilder labels = new StringBuilder();
        for (Produit produit : produits) {
            labels.append("'"+ produit.getNom() + "',");
        }
        return labels.substring(0, labels.length() - 1);
    }

    public String getData() {
        if (this.getProduits().length == 0) return "";
        StringBuilder labels = new StringBuilder();
        for (Produit produit : produits) {
            labels.append(produit.getQuantite() + ",");
        }
        return labels.substring(0, labels.length() - 1);
    }

    public Graph(Produit[] produits, Produit[] produits2) {
        this.setProduits(produits);
        this.setProduitsBon(produits2);
    }

}