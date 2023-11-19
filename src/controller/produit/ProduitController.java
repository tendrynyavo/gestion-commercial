package controller.produit;

import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.graph.Graph;
import model.produit.Produit;

public class ProduitController extends Produit {

    public ProduitController() throws Exception {
        super();
    }


    @url("produit/valider.do")
    public ModelView validerProduit(String besoin) throws Exception {
        this.valider();
        return new ModelView().sendRedirect("/commercial/besoin/detail.do?id=" + besoin);
    }

    @url("produit/liste-group.do")
    public ModelView listGroup() throws Exception {
        return new ModelView("produit/liste-group")
            .addItem("graph", new Graph(Produit.getProduitGroup()));
    }
    
}
