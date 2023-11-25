package controller.produit;

import java.sql.Connection;
import java.util.HashMap;
import etu2070.annotation.auth;
import etu2070.annotation.session;
import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.graph.Graph;
import model.produit.Produit;
import model.demande.*;

public class ProduitController extends Produit {

    HashMap<String, Object> session;

    public HashMap<String, Object> getSession() {
        return session;
    }

    public void setSession(HashMap<String, Object> session) {
        this.session = session;
    }

    public ProduitController() throws Exception {
        super();
    }

    @auth("Chef de departement")
    @url("produit/post-valider.do")
    public ModelView postValiderProduit(String besoin) throws Exception {
        this.postValider();
        return new ModelView().sendRedirect("/commercial/besoin/detail.do?id=" + besoin);
    }

    @auth("Chef de departement")
    @url("produit/valider.do")
    public ModelView validerProduit(String departement) throws Exception {
        this.valider(departement);
        return new ModelView().sendRedirect("/commercial/produit/liste-group.do");
    }

    @auth
    @session
    @url("produit/liste-group.do")
    public ModelView listGroup() throws Exception {
        try(Connection connection = new Produit().getConnection()){
            return new ModelView("produit/liste-group")
                .addItem("graph", new Graph(Produit.getProduitGroup("10", connection), Produit.getProduitGroup("15", connection)));
        }
    }

    @auth
    @url("produit/bon.do")
    public ModelView generateBons() throws Exception{
        Bon bon = new Bon();
        bon.generateBons();
        return new ModelView().sendRedirect("/commercial/produit/liste-group.do");
    }
    
}