package model.departement;

import model.demande.Proforma;
import model.produit.Produit;

public class Graph {

    Proforma[] proformas;

    public Proforma[] getProformas() {
        return proformas;
    }

    public void setProformas(Proforma[] proformas) {
        this.proformas = proformas;
    }

    public String getLabels() {
        if (this.getProformas().length == 0) return "";
        StringBuilder labels = new StringBuilder();
        for (Proforma proforma : this.getProformas()) {
            labels.append("'"+ proforma.getDate() + "',");
        }
        return labels.substring(0, labels.length() - 1);
    }

    public double getPrix(Produit produit, Proforma proforma) throws Exception {
        for (Produit p : proforma.getProduits()) {
            if (p.equals(produit)) {
                return p.getPrix();
            }
        }
        return 0.0;
    }

    public String getDatasets() throws Exception {
        if (this.getProformas().length == 0) return "";
        Produit[] produits = (Produit[]) new Produit().findAll("nom");
        StringBuilder json = new StringBuilder();
        for (Produit produit : produits) {
            String datasets = "{"+
                "label: '%s',"+
                "data: [%s],"+
                "fill: false,"+
                "tension: 0.1"+
            "},";
            StringBuilder data = new StringBuilder();
            for (Proforma facture : this.getProformas()) {
                data.append(this.getPrix(produit, facture) + ",");
            }
            datasets = String.format(datasets, produit.getNom(), data.substring(0, data.length() - 1));
            json.append(datasets);
        }
        return json.substring(0, json.length() - 1);
    }
    
}