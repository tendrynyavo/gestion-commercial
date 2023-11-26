package controller.demande;

import java.sql.Connection;

import etu2070.annotation.auth;
import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.demande.Proforma;
import model.departement.Fournisseur;
import model.produit.Produit;

public class ProformaController extends Proforma {

    public ProformaController() throws Exception {
        super();
    }

    @auth
    @url("proforma/formulaire.do")
    public ModelView formulaire(String fournisseur) throws Exception {
        return new ModelView("proforma/creation-proforma")
                .addItem("fournisseur", new Fournisseur(fournisseur));
    }

    @auth
    @url("proforma/insert.do")
    public ModelView insertProforma() throws Exception {
        this.insert(null);
        return new ModelView()
                .sendRedirect("http://localhost:8080/commercial/proforma/liste-produit.do?id=" + this.getId());
    }

    @auth
    @url("proforma/liste-produit.do")
    public ModelView listProduit() throws Exception {
        try (Connection connection = this.getConnection()) {
            return new ModelView("proforma/liste-produit-proforma")
                    .addItem("proforma", new Proforma().getProforma(this.getId(), connection))
                    .addItem("produits", new Produit().findAll(connection, null));
        }
    }

    @auth
    @url("proforma/ajout-produit.do")
    public ModelView ajouterProduit(String produit, String quantite, String prixUnitaire, String tva) throws Exception {
        new Proforma().ajouterProduit(this.getId(), produit, quantite, prixUnitaire, tva);
        return new ModelView()
                .sendRedirect("http://localhost:8080/commercial/proforma/liste-produit.do?id=" + this.getId());
    }

    @auth
    @url("proforma/detail.do")
    public ModelView detail(String fournisseur) throws Exception {
        try (Connection connection = this.getConnection()) {
            return new ModelView("proforma/proforma-detail")
                    .addItem("fournisseur", new Fournisseur().getFournisseur(fournisseur, connection))
                    .addItem("proforma", new Proforma().getProforma(this.getId(), connection));
        }
    }

}
