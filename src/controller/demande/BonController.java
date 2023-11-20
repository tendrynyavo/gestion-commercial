package controller.demande;

import etu2070.framework.*;
import etu2070.annotation.*;
import model.demande.Bon;

public class BonController{
	// INona ny atao ato

	@url("bon/update.do")
	public ModelView updateBon( String mode, String date, String avance, String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.modify( mode, date, avance, idBon );
		return new ModelView().sendRedirect("/commercial/besoin/demande.do");
	}

	public ModelView validateFirst( String mode, String date, String avance, String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.modify( mode, date, avance, idBon );
		return new ModelView().sendRedirect("/commercial/besoin/demande.do");
	}

	public ModelView validateSecond( String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.modify( mode, date, avance, idBon );
		return new ModelView().sendRedirect("/commercial/besoin/demande.do");
	}

	public ModelView validateFirst( String mode, String date, String avance, String idBon ) throws Exception{
		Bon bon = new Bon();
		bon.modify( mode, date, avance, idBon );
		return new ModelView().sendRedirect("/commercial/besoin/demande.do");
	}

}