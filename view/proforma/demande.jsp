<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.departement.Fournisseur" %>
<%
    Fournisseur[] fournisseurs = (Fournisseur[]) request.getAttribute("fournisseurs");
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
    <title>Demande Proforma</title>
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
                            <a href="/commercial/demande/proforma.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-file-earmark-text fs-4"></i>
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
            <div class="col-md-6 mx-auto p-3 min-vh-100">
            <div class="row p-3">
                <div class="col">
                    <div class="bg-white p-5 rounded-container shadow-sm">
                        <h4 style="font-weight: bold" class="mb-4">Demande de proforma</h4>
                            <form action="/commercial/demande/insert.do" method="POST">
                                 <div class="mb-4 row">
                                    <label for="fournisseur" class="col-sm-2 col-form-label">Fournisseur</label>
                                    <div class="col-sm-10">
                                        <select class="form-select" style="border-radius: 15px;" name="fournisseur">
                                            <% for (Fournisseur fournisseur : fournisseurs) { %>
                                            <option value="<%=fournisseur.getId() %>"><%=fournisseur.getNom() %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <button class="btn">Suivant</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>