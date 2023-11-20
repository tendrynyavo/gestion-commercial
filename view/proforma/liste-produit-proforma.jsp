<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.produit.Produit" %>
<%@page import="model.demande.Proforma" %>
<%

    Proforma proforma = (Proforma) request.getAttribute("proforma");
    Produit[] produits = (Produit[]) request.getAttribute("produits");

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
                            <a href="/commercial/fournisseur/liste.do" class="link-dark nav-link rounded-circle active-item">
                                <i style="color: white;" class="bi-basket fs-4"></i>
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
                    <div class="col">
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Detail du proforma du <%=proforma.getDate() %> par <%=proforma.getFournisseur().getNom() %></h4>
                            <form action="/commercial/proforma/ajout-produit.do" method="POST">
                                <div class="mb-4 row">
                                    <label for="article" class="col-sm-2 col-form-label">Article</label>
                                    <div class="col-sm-10">
                                        <select class="form-select" style="border-radius: 15px;" name="produit">
                                            <% for (Produit produit : produits) { %>
                                            <option value="<%=produit.getId() %>"><%=produit.getNom() %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                                <div class="mb-4 row">
                                    <label class="col-sm-2 col-form-label">Quantite</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="quantite" class="form-control" style="border-radius: 15px;">
                                    </div>
                                </div>
                                <div class="mb-4 row">
                                    <label class="col-sm-2 col-form-label">Prix Unitaire</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="prixUnitaire" class="form-control" style="border-radius: 15px;">
                                    </div>
                                </div>
                                <div class="mb-4 row">
                                    <label class="col-sm-2 col-form-label">TVA</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="tva" class="form-control" style="border-radius: 15px;">
                                    </div>
                                </div>
                                <input type="hidden" name="id" value="<%=proforma.getId() %>">
                                <div class="row">
                                    <button class="btn">Ajouter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col">
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Liste des articles</h4>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col">Reference</th>
                                    <th scope="col">Article</th>
                                    <th scope="col">Unite</th>
                                    <th scope="col">Quantite</th>
                                    <th scope="col">Prix Unitaire</th>
                                    <th scope="col">TVA</th>
                                  </tr>
                                </thead>
                                <tbody>
                                    <% for (Produit produit : proforma.getProduits()) { %>
                                    <tr>
                                        <th scope="row"><%=produit.getReference() %></th>
                                        <td><%=produit.getNom() %></td>
                                        <td><%=produit.getUnite() %></td>
                                        <td><%=produit.getQuantite() %></td>
                                        <td><%=produit.getPrix() %></td>
                                        <td><%=produit.getTva() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                              </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>