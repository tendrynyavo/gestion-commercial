package controller.demande;

import java.sql.Connection;
import java.sql.Date;
import java.util.HashMap;
import etu2070.annotation.auth;
import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.demande.Proforma;
import model.departement.Fournisseur;
import model.employe.Employe;
import model.produit.Produit;
import model.proforma.Demande;
import model.proforma.Mail;
import etu2070.annotation.session;

public class DemandeController extends Demande {
    HashMap<String, Object> session;

    public HashMap<String, Object> getSession() {
        return session;
    }

    public void setSession(HashMap<String, Object> session) {
        this.session = session;
    }

    public DemandeController() throws Exception {
        super();
    }

    @url("demande/proforma.do")
    public ModelView demande() throws Exception {
        try (Connection connection = this.getConnection()) {
            return new ModelView("proforma/demande")
                    .addItem("fournisseurs", new Fournisseur().findAll(null));
        }
    }

    @session
    @auth
    @url("demande/insert.do")
    public ModelView insertDemande() throws Exception {
        try (Connection connection = this.getConnection()) {
            Employe employe = (Employe) getSession().get("employe");
            Demande d = new Demande();
            d.setSociete(employe.getSociete());
            d.setFournisseur(getFournisseur());
            d.setDateDemande(new Date(System.currentTimeMillis()));
            d.insert(connection);
            connection.commit();
            d = getFournisseur().getLastDemande(connection);
            return new ModelView()
                    .sendRedirect("http://localhost:8080/commercial/demande/liste-proforma.do?id="
                            + d.getId());
        }
    }

    @auth
    @url("demande/liste-proforma.do")
    public ModelView listeDemande() throws Exception {
        try (Connection connection = this.getConnection()) {
            return new ModelView("proforma/details-demande")
                    .addItem("demande", new Demande().getDemande(this.getId(), connection))
                    .addItem("produits", new Produit().findAll(null));
        }
    }

    @auth
    @url("demande/ajout-produit-proforma.do")
    public ModelView ajouterProduit(String produit, String quantite) throws Exception {
        try (Connection connection = this.getConnection()) {
            new Demande().ajouterProduit(this.getId(), produit, quantite, connection);
            return new ModelView()
                    .sendRedirect("http://localhost:8080/commercial/demande/liste-proforma.do?id=" + this.getId());
        }
    }

    @session
    @auth
    @url("demande/valider.do")
    public ModelView checkStock(String idproduit, String quantite) throws Exception {
        try (Connection connection = this.getConnection()) {
            Fournisseur f = (Fournisseur) getSession().get("fournisseur");
            double stock = f.checkStock(idproduit, this.getDateDemande(), connection);
            double qtt = Double.parseDouble(quantite);
            if (stock >= qtt) {
                this.validerProduit(idproduit, qtt, connection);
            } else {
                return new ModelView("erreur/erreur")
                        .addItem("Exception", new Exception("Votre stock pour ce produit est insuffisant"));
            }
            return new ModelView()
                    .sendRedirect("http://localhost:8080/commercial/fournisseur/detaildemande.do?id=" + this.getId());
        }
    }

    @auth
    @url("demande/generer_proforma.do")
    public ModelView generate(String proforma) throws Exception {
        try (Connection connection = this.getConnection()) {
            Demande d = new Demande().getDemandeValide(this.getId(), connection);
            Proforma pf = new Proforma();
            pf.setDate(new Date(System.currentTimeMillis()));
            pf.setFournisseur(d.getFournisseur());
            if (proforma == null) {
                pf = pf.insertion(d.getSociete().getId(), connection);
            } else {
                pf.setId(proforma);
            }
            return new ModelView("proforma/validation")
                    .addItem("demande", d)
                    .addItem("proforma", pf);
        }
    }

    @session
    @auth
    @url("demande/inserer_validation.do")
    public ModelView valider(String proforma, String societe, String quantite, String produit, String pu, String tva)
            throws Exception {
        try (Connection connection = this.getConnection()) {
            Demande d = new Demande().getDemandeValide(this.getId(), connection);
            Proforma pf = new Proforma(proforma);
            pf.insertionDetail(societe, quantite, produit, pu, tva, connection);
            d.validerProduitProforma(produit, quantite, connection);
            d = new Demande().getDemandeValide(this.getId(), connection);
            if (d.getProduits().length > 0) {
                return new ModelView()
                        .sendRedirect(
                                "http://localhost:8080/commercial/demande/generer_proforma.do?id=" + this.getId()
                                        + "&proforma=" + proforma);
            } else {
                Fournisseur f = (Fournisseur) getSession().get("fournisseur");
                Proforma p = f.getLastProforma(connection);
                Mail.creerExcel(p);
                Mail.ouvrirExcel();
                Mail.envoieMail(p.getFournisseur().getMail(), p.getFournisseur().getMotDePasse(),
                        p.getSociete().getEmail());
                return new ModelView()
                        .sendRedirect(
                                "http://localhost:8080/commercial/fournisseur/demande_proforma.do");
            }
        }
    }
}