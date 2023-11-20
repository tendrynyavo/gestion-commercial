package model.validation;

import connection.BddObject;

public class Validation extends BddObject {

    Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStringStatus() {
        String status = null;
        switch (this.getStatus()) {
            case 25:
                status = "Confirmer";
                break;

            case 20:
                status = "Valider";
                break;

            case 15:
                status = "En attente de bon de commande";
                break;

            case 10:
                status = "Post-valide";
                break;

            case 0:
                status = "En attente";
                break;
        
            default:
                status = "";
                break;
        }
        return status;
    }

    public Validation() throws Exception {
        super();
    }
    
}
