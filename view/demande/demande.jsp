<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.employe.Employe" %>
<%

    Employe[] employes = (Employe[]) request.getAttribute("employes");

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
    <title>Demande</title>
</head>
<body>
    <div class="container-fluid">
        <div class="row" style="background-color: #f5f5f5;">
            <div class="col-sm-auto sticky-top m-3 rounded-sidebar shadow-sm" style="background-color: #353e37;">
                <div class="d-flex flex-sm-column rounded-sidebar flex-row flex-nowrap align-items-center sticky-top" style="background-color: #353e37;">
                    <ul class="p-3 nav nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                        <li class="mt-4">
                            <a href="/commercial/besoin/demande.do" class="link-dark nav-link rounded-circle active-item">
                                <i style="color: white;" class="bi-bag-plus fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/besoin/detail.do" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-list-nested fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="/commercial/produit/liste-group.do" class="link-dark nav-link rounded-circle item">
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
                <div class="bg-white p-5 rounded-container w-50 shadow-sm">
                    <h4 style="font-weight: bold" class="mb-4">Demande d'équipement</h4>
                    <form action="/commercial/besoin/insert.do" method="POST">
                        <div class="mb-4 row">
                            <label for="description" class="col-sm-2 col-form-label">Date</label>
                            <div class="col-sm-10">
                                <input type="date" name="date" id="description" class="form-control" style="border-radius: 15px;">
                            </div>
                        </div>
                        <div class="mb-4 row">
                            <label for="description" class="col-sm-2 col-form-label">Employe</label>
                            <div class="col-sm-10">
                                <select class="form-select" style="border-radius: 15px;" name="employe">
                                    <% for (Employe employe : employes) { %>
                                    <option value="<%=employe.getId() %>"><%=employe.getNom() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                        <div class="mb-4 row">
                            <label for="description" class="col-sm-2 col-form-label">Description</label>
                            <div class="col-sm-10">
                                <textarea name="description" id="" cols="30" rows="10" class="form-control">Aussi, je vous serais reconnaissant de bien vouloir me fournir [détail du matériel souhaité], afin que je puisse réaliser mes tâches dans des conditions de confort et de sécurité optimales.</textarea>
                            </div>
                        </div>
                        <div class="row">
                            <button class="btn">Demander</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>