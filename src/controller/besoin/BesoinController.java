package controller.besoin;

import java.sql.Connection;

import etu2070.annotation.auth;
import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.besoin.Besoin;
import model.employe.Employe;
import model.produit.Produit;

public class BesoinController extends Besoin {

    public BesoinController() throws Exception {
        super();
    }

    @auth
    @url("besoin/demande.do")
    public ModelView formulaire() throws Exception {
        return new ModelView("demande/demande")
            .addItem("employes", new Employe().findAll(null));
    }

    @auth
    @url("besoin/insert.do")
    public ModelView insertBesoin() throws Exception {
        this.insert(null);
        return new ModelView().sendRedirect("http://localhost:8080/commercial/besoin/liste-demande.do?id=" + this.getId());
    }

    @auth
    @url("besoin/liste-demande.do")
    public ModelView listeDemande() throws Exception {
        try (Connection connection = this.getConnection()) {
            return new ModelView("demande/liste-produit-demande")
                .addItem("besoin", new Besoin().getBesoin(this.getId(), connection))
                .addItem("produits", new Produit().findAll(connection, null));
        }
    }

    @auth
    @url("besoin/ajout-produit.do")
    public ModelView ajouterProduit(String produit, String quantite) throws Exception {
        new Besoin().ajouterProduit(this.getId(), produit, quantite);
        return new ModelView().sendRedirect("http://localhost:8080/commercial/besoin/liste-demande.do?id=" + this.getId());
    }

    @auth
    @url("besoin/detail.do")
    public ModelView detail() throws Exception {
        try (Connection connection = this.getConnection()) {
            return new ModelView("demande/detail")
                .addItem("besoins", new Besoin().findAll(connection, "date_besoin ASC"))
                .addItem("besoin", new Besoin().getBesoin(this.getId(), connection));
        }
    }
    
}