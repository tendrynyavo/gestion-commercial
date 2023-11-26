package controller.fournisseur;

import java.sql.Connection;
import java.util.HashMap;

import etu2070.annotation.auth;
import etu2070.annotation.session;
import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.departement.Fournisseur;
import model.proforma.Demande;

public class FournisseurController extends Fournisseur {

    HashMap<String, Object> session;

    public HashMap<String, Object> getSession() {
        return session;
    }

    public void setSession(HashMap<String, Object> session) {
        this.session = session;
    }

    public FournisseurController() throws Exception {
        super();
    }

    @url("login/login-fournisseur.do")
    public ModelView login() {
        return new ModelView("login/login-fournisseur");
    }

    @url("login/check-fournisseur.do")
    public ModelView check() throws Exception {
        Fournisseur f = Fournisseur.login(this.getMail(), this.getMotDePasse());
        ModelView view = new ModelView();
        view.addSession("fournisseur", f);
        view.addSession("isconnected", true);
        return view.sendRedirect("/commercial/fournisseur/demande_proforma.do");
    }

    @url("log-out-fournisseur.do")
    public ModelView logOut() {
        ModelView view = new ModelView();
        view.setInvalidate(true);
        return view.sendRedirect("/commercial/login/login-fournisseur.do");
    }

    @auth
    @url("fournisseur/liste.do")
    public ModelView list() throws Exception {
        return new ModelView("fournisseur/liste-fournisseur")
                .addItem("fournisseurs", new Fournisseur().findAll(null));
    }

    @session
    @auth
    @url("fournisseur/demande_proforma.do")
    public ModelView listproforma() throws Exception {
        Fournisseur f = (Fournisseur) getSession().get("fournisseur");
        return new ModelView("fournisseur/liste-demande-proforma")
                .addItem("demande_proforma", new Fournisseur(f.getId()).getDemande());
    }

    @session
    @auth
    @url("fournisseur/detaildemande.do")
    public ModelView detaildemande() throws Exception {
        try (Connection connection = this.getConnection()) {
            Fournisseur f = (Fournisseur) getSession().get("fournisseur");
            return new ModelView("fournisseur/detail-demande")
                    .addItem("demande_proforma", new Fournisseur(f.getId()).getDemande())
                    .addItem("demande", new Demande().getDemande(this.getId(), connection))
                    .addItem("demande_valide", new Demande().getDemandeValide(this.getId(), connection));
        }
    }

}
