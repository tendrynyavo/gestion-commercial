<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.proforma.Demande" %>
<%@page import="model.produit.Produit" %>
<%
    Demande[] demande = (Demande[]) request.getAttribute("demande_proforma");
    Demande dd = (Demande) request.getAttribute("demande");
    Demande dv = (Demande) request.getAttribute("demande_valide");
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
    <title>Liste</title>
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
                            <a href="/commercial/produit/liste-group.do" class="link-dark nav-link rounded-circle active-item">
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
                                    <% for(Demande d : demande) { %>
                                    <tr>
                                        <th scope="row"><%=d.getSociete().getNom() %></th>
                                        <td><%=d.getDateDemande() %></td>
                                        <td><a href="/commercial/fournisseur/detaildemande.do?id=<%=d.getId() %>" class="link-dark"><i class="bi-arrow-90deg-right fs-5"></i></a></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-7 mx-auto">
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold">Liste des produits</h4>
                            <table class="table mt-4">
                                <thead>
                                  <tr>
                                    <th scope="col">Reference</th>
                                    <th scope="col">Article</th>
                                    <th scope="col">Unite</th>
                                    <th scope="col">Quantite</th>
                                    <th scope="col"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <% for (Produit produit : dd.getProduits()) { %>
                                  <tr>
                                    <th class="align-middle" scope="row"><%=produit.getReference() %></th>
                                    <td class="align-middle"><%=produit.getNom() %></td>
                                    <td class="align-middle"><%=produit.getUnite() %></td>
                                    <td class="align-middle"><%=produit.getQuantite() %></td>
                                    <td class="align-middle"><a class="link-dark" href="/commercial/demande/valider.do?id=<%=dd.getId()%>&dateDemande=<%=dd.getDateDemande()%>&idproduit=<%=produit.getId()%>&quantite=<%=produit.getQuantite()%>"><i class="bi-check fs-3"></i></a></td>
                                  </tr>
                                  <% } %>
                                </tbody>
                              </table>
                        </div>
                        <div class="bg-white p-5 rounded-container shadow-sm mt-3">
                            <h4 style="font-weight: bold" class="mb-4">Liste des produits déja validé</h4>
                            <table class="table mt-4">
                              <thead>
                                <tr>
                                  <th scope="col">Reference</th>
                                  <th scope="col">Article</th>
                                  <th scope="col">Unite</th>
                                  <th scope="col">Quantite</th>
                                </tr>
                              </thead>
                              <tbody>
                                <% for (Produit produit : dv.getProduits()) { %>
                                <tr>
                                  <th class="align-middle" scope="row"><%=produit.getReference() %></th>
                                  <td class="align-middle"><%=produit.getNom() %></td>
                                  <td class="align-middle"><%=produit.getUnite() %></td>
                                  <td class="align-middle"><%=produit.getQuantite() %></td>
                                </tr>
                                <% } %>
                              </tbody>
                            </table>
                            <%if(dv.getProduits().length>0) { %>
                            <a class="btn" href="/commercial/demande/generer_proforma.do?id=<%=dv.getId()%>">Generer un proforma</a>
                            <% } %>
                          </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>