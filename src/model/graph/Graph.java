package model.graph;

import model.produit.Produit;

public class Graph {

    Produit[] produits;
    
    public void setProduits(Produit[] produits) {
        this.produits = produits;
    }

    public Produit[] getProduits() {
        return produits;
    }

    public String getLabels() {
        StringBuilder labels = new StringBuilder();
        for (Produit produit : produits) {
            labels.append("'"+ produit.getNom() + "',");
        }
        return labels.substring(0, labels.length() - 1);
    }

    public String getData() {
        StringBuilder labels = new StringBuilder();
        for (Produit produit : produits) {
            labels.append(produit.getQuantite() + ",");
        }
        return labels.substring(0, labels.length() - 1);
    }

    public Graph(Produit[] produits) {
        this.setProduits(produits);
    }

}
