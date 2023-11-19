package controller.fournisseur;

import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.departement.Fournisseur;

public class FournisseurController extends Fournisseur {

    public FournisseurController() throws Exception {
        super();
    }

    @url("fournisseur/liste.do")
    public ModelView list() throws Exception {
        return new ModelView("fournisseur/liste-fournisseur")
            .addItem("fournisseurs", new Fournisseur().findAll(null));
    }
    
}
