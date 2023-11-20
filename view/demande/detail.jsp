<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.besoin.Besoin" %>
<%@page import="model.produit.Produit" %>
<%

    Besoin[] besoins = (Besoin[]) request.getAttribute("besoins");
    Besoin detail = (Besoin) request.getAttribute("besoin");

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
    <title>Liste demande</title>
</head>
<body>
    <div class="container-fluid">
        <div class="row" style="background-color: #f5f5f5;">
            <div class="col-sm-auto sticky-top m-3 rounded-sidebar shadow-sm sticky-top" style="background-color: #353e37;">
                <div class="d-flex flex-sm-column rounded-sidebar flex-row flex-nowrap align-items-center sticky-top" style="background-color: #353e37;">
                    <ul class="p-3 nav nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                        <li class="nav-item mt-3">
                            <a href="/commercial/besoin/detail.do" class="link-dark nav-link rounded-circle active-item">
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
                            <a href="#" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-box-arrow-left fs-4"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-sm p-3 min-vh-100">
                <div class="row p-3">
                    <div class="col-4">
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Liste des demandes</h4>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col">Employe</th>
                                    <th scope="col">Date</th>
                                    <th scope="col"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                    <% for(Besoin besoin : besoins) { %>
                                    <tr>
                                        <th scope="row"><%=besoin.getEmploye().getNomPrenom() %></th>
                                        <td><%=besoin.getDate() %></td>
                                        <td><a href="/commercial/besoin/detail.do?id=<%=besoin.getId() %>" class="link-dark"><i class="bi-arrow-90deg-right fs-5"></i></a></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <a href="/commercial/besoin/demande.do" class="btn"><i class="bi-plus fs-4"></i></a>
                        </div>
                    </div>
                    <div class="col-8">
                        <% if (detail != null) { %>
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Detail de la demande</h4>
                            <div class="d-flex">
                                <div class="col">
                                    <div class="w-75 p-4 rounded-container-detail shadow-sm">
                                        <h4 class="text-white">Information</h4>
                                        <ul class="text-white">
                                            <li>Employe : <%=detail.getEmploye().getNomPrenom() %></li>
                                            <li>Departement : <%=detail.getEmploye().getDepartement().getNom() %></li>
                                            <li>Date : <%=detail.getDate() %></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="float-end w-75 p-4 rounded-container-detail shadow-sm" style="height: 172px;">
                                        <h4 class="text-white">Description</h4>
                                        <div class="description">
                                            <p class="text-white"><%=detail.getDescription() %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table mt-5">
                                <thead>
                                  <tr>
                                    <th scope="col">Reference</th>
                                    <th scope="col">Article</th>
                                    <th scope="col">Unite</th>
                                    <th scope="col">Quantite</th>
                                    <th scope="col">Status</th>
                                    <th scope="col"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                    <% for (Produit produit : detail.getProduits()) { %>
                                    <tr>
                                        <th class="align-middle" scope="row"><%=produit.getReference() %></th>
                                        <td class="align-middle"><%=produit.getNom() %></td>
                                        <td class="align-middle"><%=produit.getUnite() %></td>
                                        <td class="align-middle"><%=produit.getQuantite() %></td>
                                        <td class="align-middle"><%=produit.getStringStatus() %></td>
                                        <td class="align-middle"><a class="link-dark" href="/commercial/produit/post-valider.do?id=<%=produit.getDemande() %>&besoin=<%=detail.getId() %>"><i class="bi-check fs-3"></i></a></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                              </table>
                              <a href="/commercial/besoin/liste-demande.do?id=<%=detail.getId() %>" class="btn"><i class="bi-plus fs-4"></i></a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>