<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="model.demande.Bon" %>
<%

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
    <title>Demande</title>
</head>
<body>
    <div class="container-fluid">
        <div class="row" style="background-color: #f5f5f5;">
            <div class="col-sm-auto sticky-top m-3 rounded-sidebar shadow-sm" style="background-color: #353e37;">
                <div class="d-flex flex-sm-column rounded-sidebar flex-row flex-nowrap align-items-center sticky-top" style="background-color: #353e37;">
                    <ul class="p-3 nav nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                        <li class="mt-4">
                            <a href="#" class="link-dark nav-link rounded-circle active-item">
                                <i style="color: white;" class="bi-bag-plus fs-4"></i>
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a href="#" class="link-dark nav-link rounded-circle item">
                                <i style="color: white;" class="bi-box-seam fs-4"></i>
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
                <div class="bg-white p-5 rounded-container w-50">
                    <h4 style="font-weight: bold" class="mb-4">Validation du bon de commande</h4>
                    <form action="/commercial/bon/update.do" method="POST">
                        <div class="mb-4 row">
                            <label for="description" class="col-sm-2 col-form-label">Date de livraison</label>
                            <div class="col-sm-10">
                                <input type="date" name="date" id="description" class="form-control" style="border-radius: 15px;">
                            </div>
                        </div>
                        <div class="mb-4 row">
                            <label for="description" class="col-sm-2 col-form-label">Mode de paiement</label>
                            <div class="col-sm-10">
                                <select class="form-select" style="border-radius: 15px;" name="mode">
                                    <option value="Cheque">Cheque</option>
                                    <option value="Virement">Virement</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-4 row">
                            <label for="description" class="col-sm-2 col-form-label">Avance</label>
                            <div class="col-sm-10">
                                <input type="text" name="avance" id="description" class="form-control" style="border-radius: 15px;">
                            </div>
                        </div>
                        <input type="hidden" name="idBon" value="<%=detail.getId() %>">
                        <div class="row">
                            <button class="btn">Valider</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>