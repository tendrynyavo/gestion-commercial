<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.proforma.Demande" %>
<%@page import="model.demande.Proforma" %>
<%
    Demande dd = (Demande) request.getAttribute("demande");
    Proforma pf = (Proforma) request.getAttribute("proforma");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/demande/demande.css">
    <title>Validation Proforma</title>
</head>
<body>
    <div class="container-fluid">
        <div class="row" style="background-color: #f5f5f5;">
            <div class="col-sm-auto sticky-top m-3 rounded-sidebar shadow-sm" style="background-color: #353e37;">
                <div class="d-flex flex-sm-column rounded-sidebar flex-row flex-nowrap align-items-center sticky-top" style="background-color: #353e37;">
                    <ul class="p-3 nav nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                        <li class="nav-item mt-3">
                            <a href="/commercial/besoin/detail.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-box-seam fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/produit/liste-group.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-view-list fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/fournisseur/liste.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-basket fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/bon/detail.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-receipt fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/log-out.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-box-arrow-left fs-4"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-sm p-3 min-vh-100">
                <div class="row p-3">
                    <div class="col">
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Validation de proforma</h4>
                                <div class="mb-4 row">
                                    <label for="description" class="col-sm-2 col-form-label">Societe</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" style="border-radius: 15px;" value="<%=dd.getSociete().getNom()%>" readonly>
                                    </div>
                                </div>
                                <h6 style="font-weight: bold" class="mb-4">Les produits</h6>
                                    <% for(int i=0;i<dd.getProduits().length;i++) { %>
                                    <form action="/commercial/demande/inserer_validation.do" method="POST">
                                        <input type="hidden" name="societe" value="<%=dd.getSociete().getId()%>">
                                        <input type="hidden" name="id" value="<%=dd.getId()%>">
                                        <div class="mb-4 row">
                                            <label class="col-sm-2 col-form-label">Produit</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" style="border-radius: 15px;" value="<%=dd.getProduits()[i].getNom()%>" readonly>
                                            </div>
                                        </div>
                                        <input type="hidden" name="produit" value="<%=dd.getProduits()[i].getId()%>">
                                        <div class="mb-4 row">
                                            <label class="col-sm-2 col-form-label">Quantite</label>
                                            <div class="col-sm-10">
                                                <input type="text" name ="quantite" class="form-control" style="border-radius: 15px;" value="<%=dd.getProduits()[i].getQuantite()%>" readonly>
                                            </div>
                                        </div>
                                        <div class="mb-4 row">
                                            <label class="col-sm-2 col-form-label">Prix Unitaire</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="pu" id="pu" class="form-control" style="border-radius: 15px;">
                                            </div>
                                        </div>
                                        <div class="mb-4 row">
                                            <label class="col-sm-2 col-form-label">TVA</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="tva" id="tva" class="form-control" style="border-radius: 15px;">
                                            </div>
                                        </div>
                                        <input type="hidden" name="proforma" value="<%=pf.getId()%>">
                                        <div class="row">
                                            <button class="btn">Valider</button>
                                        </div>
                                    </form>
                                    <% }
                                    %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>