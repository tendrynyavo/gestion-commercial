package controller.employe;

import etu2070.annotation.url;
import etu2070.framework.ModelView;
import model.employe.Employe;

public class EmployeController extends Employe {

    public EmployeController() throws Exception {
        super();
    }

    @url("login/login.do")
    public ModelView login() {
        return new ModelView("login/login");
    }

    @url("login/check.do")
    public ModelView check() throws Exception {
        Employe employe = Employe.login(this.getNom(), this.getPassword());
        ModelView view = new ModelView();
        view.addSession("employe", employe);
        view.addSession("isconnected", true);
        view.addSession("profil", employe.getFonction().getNom());
        return view.sendRedirect("/commercial/");
    }
    
}
