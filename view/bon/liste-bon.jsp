<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.demande.Bon" %>
<%@page import="model.produit.Produit" %>
<%

    Bon[] bons = (Bon[]) request.getAttribute("bons");
    Bon detail = (Bon) request.getAttribute("bon");

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
                            <a href="/commercial/bon/detail.do" class="link-dark nav-link rounded-circle active-item">
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
                            <h4 style="font-weight: bold" class="mb-4">Liste des bon de commande</h4>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col">Fournisseur</th>
                                    <th scope="col">Date</th>
                                    <th scope="col"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                    <% for (Bon bon : bons) { %>
                                    <tr>
                                        <th scope="row"><%=bon.getNom() %></th>
                                        <td><%=bon.getCreation() %></td>
                                        <td><a href="/commercial/bon/detail.do?id=<%=bon.getId() %>" class="link-dark"><i class="bi-arrow-90deg-right fs-5"></i></a></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-8">
                        <% if (detail != null) { %>
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Detail de proforma</h4>
                            <div class="d-flex">
                                <div class="col">
                                    <div class="w-75 p-4 rounded-container-detail shadow-sm">
                                        <h4 class="text-white">Information</h4>
                                        <ul class="text-white">
                                            <li>Fournisseur : <%=detail.getNom() %></li>
                                            <li>Email : <%=detail.getEmail() %></li>
                                            <li>Date : <%=detail.getCreation() %></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="float-end w-75 p-4 rounded-container-detail shadow-sm">
                                        <h4 class="text-white">Information</h4>
                                        <ul class="text-white">
                                            <li>Status : <%=detail.getStringStatus() %></li>
                                            <li>Mode paiement : <%=detail.getPaiement() %></li>
                                            <li>Date de livraison : <%=detail.getLivraison() %></li>
                                            <li>Avance : <%=detail.getAvance() %></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <a href="/commercial/bon/choix.do?id=<%=detail.getId() %>" class="btn mt-4">Mode de paiement</a>
                            <table class="table mt-5">
                                <thead>
                                    <tr>
                                        <th scope="col">Reference</th>
                                        <th scope="col">Article</th>
                                        <th scope="col">Unite</th>
                                        <th scope="col">Quantite</th>
                                        <th scope="col">Prix Unitaire</th>
                                        <th scope="col">TVA</th>
                                        <th scope="col">Montant</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Produit produit : detail.getProduits()) { %>
                                    <tr>
                                        <th class="align-middle" scope="row"><%=produit.getReference() %></th>
                                        <td class="align-middle"><%=produit.getNom() %></td>
                                        <td class="align-middle"><%=produit.getUnite() %></td>
                                        <td class="align-middle"><%=produit.getQuantite() %></td>
                                        <td class="align-middle"><%=produit.getPrix() %></td>
                                        <td class="align-middle"><%=produit.getTvaPrice() %></td>
                                        <td class="align-middle"><%=produit.getMontant() %></td>
                                    </tr>
                                    <% } %>
                                    <tr>
                                        <th>Montant</th>
                                        <td>N/A</td>
                                        <td>N/A</td>
                                        <td>N/A</td>
                                        <td><%= detail.getPrixHT() %></td>
                                        <td><%= detail.getTVATotal()  %></td>
                                        <td><%= detail.getMontant()  %></td>
                                    </tr>
                                </tbody>
                                <tfoot>

                                    <tr>
                                        <table>
                                            <thead>
                                                <th>La société</th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th>Le fournisseur</th>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>Société Milay</td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td><%= detail.getNom() %></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </tr>
                                </tfoot>
                            </table>                                        
                            Arrété le present bon de commande à la somme de 
                            <strong>
                                <%= detail.getMontantAsLetter() %> Ariary, le <%= java.time.LocalDate.now() %>
                            </strong>
                            <a href="" class="btn">Valider</a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>