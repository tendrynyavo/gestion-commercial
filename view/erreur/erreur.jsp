<%
    Exception e=(Exception)request.getAttribute("Exception");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <title>Page d'Erreur</title>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .error-container {
            text-align: center;
        }

        .error-code {
            font-size: 10rem;
            font-weight: bold;
            color: #dc3545;
        }

        .error-message {
            font-size: 2rem;
            color: #495057;
        }

        .error-description {
            font-size: 1.2rem;
            color: #6c757d;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">Oops!</div>
        <div class="error-message">Erreur</div>
        <div class="error-description"><%=e.getMessage()%></div>
    </div>
</body>
</html>
