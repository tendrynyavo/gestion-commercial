<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.produit.Produit" %>
<%@page import="model.graph.Graph" %>
<%

  Graph graph = (Graph) request.getAttribute("graph");

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
                        <li class="mt-4">
                            <a href="/commercial/besoin/demande.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-bag-plus fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/besoin/detail.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-list-nested fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/produit/liste-group.do" class="link-dark nav-link rounded-circle active-item">
                                <i style="color: white;" class="bi-view-list fs-4"></i>
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
                    <div class="col-5">
                        <div class="bg-white rounded-container shadow-sm p-5 mx-auto">
                            <h4 style="font-weight: bold" class="mb-4">Graphe par produit</h4>
                            <canvas id="myChart"></canvas>
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
                                    <th scope="col">Status</th>
                                    <th scope="col"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <% for (Produit produit : graph.getProduits()) { %>
                                  <tr>
                                    <th class="align-middle" scope="row"><%=produit.getReference() %></th>
                                    <td class="align-middle"><%=produit.getNom() %></td>
                                    <td class="align-middle"><%=produit.getUnite() %></td>
                                    <td class="align-middle"><%=produit.getQuantite() %></td>
                                    <td class="align-middle"><%=produit.getStringStatus() %></td>
                                    <td class="align-middle"><i class="bi-check fs-3"></i></td>
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
      
      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
      
      <script>
        const ctx = document.getElementById('myChart');
      
        new Chart(ctx, {
          type: 'doughnut',
          data: {
            labels: [<%=graph.getLabels() %>],
            datasets: [{
              label: 'Quantite',
              data: [<%=graph.getData() %>],
              borderWidth: 0
            }]
          },
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