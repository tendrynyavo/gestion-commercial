<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/demande/demande.css">
    <title>Login</title>
</head>
<body>
    <div class="bg-white p-5 rounded-container w-50 mx-auto mt-5">
        <h4 style="font-weight: bold" class="mb-4">Login</h4>
        <form action="/commercial/login/check.do" method="POST">
            <div class="mb-4 row">
                <label for="description" class="col-sm-2 col-form-label">Nom</label>
                <div class="col-sm-10">
                    <input type="text" name="nom" id="description" class="form-control" style="border-radius: 15px;">
                </div>
            </div>
            <div class="mb-4 row">
                <label for="description" class="col-sm-2 col-form-label">Mot de passe</label>
                <div class="col-sm-10">
                    <input type="password" name="password" id="description" class="form-control" style="border-radius: 15px;">
                </div>
            </div>
            <div class="row">
                <button class="btn">Valider</button>
            </div>
        </form>
    </div>
    </div>
</body>
</html>