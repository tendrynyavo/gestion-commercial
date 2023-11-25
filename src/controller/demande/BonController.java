package controller.demande;

import etu2070.framework.*;
import java.sql.Connection;
import connection.BddObject;
import etu2070.annotation.*;
import model.demande.Bon;

public class BonController extends Bon{
	// INona ny atao ato

	public BonController() throws Exception {
		super();
	}

	@auth
	@url("bon/update.do")
	public ModelView updateBon( String mode, String date, String avance, String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.modify( mode, date, avance, idBon );
		return new ModelView().sendRedirect("/commercial/bon/detail.do?id="+idBon);
	}

	@auth
	@url("bon/pass-first-validation.do")
	public ModelView validateFirst( String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.passFirstValidation( idBon );
		return new ModelView().sendRedirect("/commercial/besoin/demande.do");
	}

	@auth
	@url("bon/pass-second-validation.do")
	public ModelView validateSecond( String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.passSecondValidation( idBon );
		return new ModelView().sendRedirect("/commercial/besoin/demande.do");
	}

	@auth
	@url("bon/pass-third-validation.do")
	public ModelView validateThrist( String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.passThirdValidation(idBon );
		return new ModelView().sendRedirect("/commercial/bon/detail.do?id=" + idBon);
	}

	@auth
	@url("bon/detail.do")
	public ModelView liste() throws Exception {
		try (Connection connection = this.getConnection()) {
			return new ModelView("bon/liste-bon")
				.addItem("bons", ((BddObject) new Bon().setTable("v_bon_commande_fournisseur")).findAll(connection, null))
				.addItem("bon", new Bon().getBonDeCommande(this.getId(), connection));
		}
	}

	@auth
	@url("bon/choix.do")
	public ModelView choix() throws Exception {
		return new ModelView("bon/choix-bon")
			.addItem("bon", this.getById());
	}

}