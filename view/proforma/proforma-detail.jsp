<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.demande.Proforma" %>
<%@page import="model.produit.Produit" %>
<%@page import="model.departement.Fournisseur" %>
<%@page import="model.departement.Graph" %>
<%

    Fournisseur fournisseur = (Fournisseur) request.getAttribute("fournisseur");
    Graph graph = fournisseur.createGraph();
    Proforma detail = (Proforma) request.getAttribute("proforma");

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
                    <div class="col-4">
                        <div class="bg-white p-5 rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Liste des profromas de <%=fournisseur.getNom() %></h4>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col">Fournisseur</th>
                                    <th scope="col">Date</th>
                                    <th scope="col"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                    <% for (Proforma proforma : fournisseur.getProformas()) { %>
                                    <tr>
                                        <th scope="row"><%=proforma.getFournisseur().getNom() %></th>
                                        <td><%=proforma.getDate() %></td>
                                        <td><a href="/commercial/proforma/detail.do?fournisseur=<%=fournisseur.getId() %>&id=<%=proforma.getId() %>" class="link-dark"><i class="bi-arrow-90deg-right fs-5"></i></a></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <a href="/commercial/proforma/formulaire.do?fournisseur=<%=fournisseur.getId() %>" class="btn"><i class="bi-plus fs-4"></i></a>
                        </div>
                    </div>
                    <div class="col-8">
                        <% if (detail != null) { %>
                        <div class="bg-white p-5 rounded-container shadow-sm mb-4">
                            <h4 style="font-weight: bold" class="mb-4">Detail de proforma</h4>
                            <div class="d-flex">
                                <div class="col">
                                    <div class="w-75 p-4 rounded-container-detail shadow-sm">
                                        <h4 class="text-white">Information</h4>
                                        <ul class="text-white">
                                            <li>Fournisseur : <%=detail.getFournisseur().getNom() %></li>
                                            <li>Email : <%=detail.getFournisseur().getMail() %></li>
                                            <li>Date : <%=detail.getDate() %></li>
                                        </ul>
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
                                        <th scope="col">Prix Unitaire</th>
                                        <th scope="col">TVA</th>
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
                                        <td class="align-middle"><%=produit.getTva() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <a href="/commercial/proforma/liste-produit.do?id=<%=detail.getId() %>" class="btn"><i class="bi-plus fs-4"></i></a>
                        </div>
                        <% } %>
                        <div class="p-5 bg-white rounded-container shadow-sm">
                            <h4 style="font-weight: bold" class="mb-4">Evolution des prix</h4>
                            <canvas id="myChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>

        const ctx = document.getElementById('myChart');
    
        // Date des proforma ASC
        const labels = [<%=graph.getLabels() %>];
        const data = {
            labels: labels,
            datasets: [<%=graph.getDatasets() %>]
        };

        new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
            }
        });

    </script>
</body>
</html>