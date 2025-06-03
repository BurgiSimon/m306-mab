<!DOCTYPE html>
<html lang="de" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>
    <g:layoutTitle default="MAB - Mitarbeiterbeurteilung"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <g:layoutHead/>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <g:link class="navbar-brand" controller="mAB" action="index">
            MAB - Mitarbeiterbeurteilung
        </g:link>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <g:link class="nav-link" controller="mAB" action="index">
                        <i class="fas fa-clipboard-list"></i> MAB Verwaltung
                    </g:link>
                </li>
                <li class="nav-item">
                    <g:link class="nav-link" controller="competence" action="index">
                        <i class="fas fa-star"></i> Kompetenzkatalog
                    </g:link>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Flash Messages -->
<div class="container mt-3">
    <g:if test="${flash.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${flash.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${flash.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </g:if>
</div>

<!-- Main Content -->
<div class="container mt-4">
    <g:layoutBody/>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>

<g:layoutScript/>
</body>
</html>