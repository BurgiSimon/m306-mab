<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Debug Information</title>
</head>
<body>
<div class="container">
    <h1>Debug Information</h1>

    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5>Database Counts</h5>
                </div>
                <div class="card-body">
                    <ul>
                        <li>MAB Status: ${mabStatusCount}</li>
                        <li>Competences: ${competenceCount}</li>
                        <li>Rating Scales: ${ratingScaleCount}</li>
                        <li>Ratings: ${ratingCount}</li>
                        <li>MABs: ${mabCount}</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5>MAB Statuses</h5>
                </div>
                <div class="card-body">
                    <g:if test="${mabStatuses}">
                        <ul>
                            <g:each in="${mabStatuses}" var="status">
                                <li>${status.id}: ${status.mabStatusName}</li>
                            </g:each>
                        </ul>
                    </g:if>
                    <g:else>
                        <p>No MAB statuses found</p>
                    </g:else>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-3">
        <g:link controller="mab" action="index" class="btn btn-primary">Go to MAB</g:link>
        <g:link controller="competence" action="index" class="btn btn-secondary">Go to Competences</g:link>
    </div>
</div>
</body>
</html>