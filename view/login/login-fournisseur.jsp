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
        <form action="/commercial/login/check-fournisseur.do" method="POST">
            <div class="mb-4 row">
                <label for="mail" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-10">
                    <input type="text" name="mail" id="mail" class="form-control" style="border-radius: 15px;" value="manoarysarobidy@gmail.com">
                </div>
            </div>
            <div class="mb-4 row">
                <label for="motDePasse" class="col-sm-2 col-form-label">Mot de passe</label>
                <div class="col-sm-10">
                    <input type="password" name="motDePasse" id="motDePasse" class="form-control" style="border-radius: 15px;" value="wumw rzpf xzif jzxr">
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