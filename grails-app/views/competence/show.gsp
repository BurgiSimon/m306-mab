<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'competence.label', default: 'Competence')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">Kompetenzkatalog</g:link></li>
                <li class="breadcrumb-item active">Kompetenz ${competence?.id}</li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1><i class="fas fa-star"></i> Kompetenz Details</h1>

            <div class="btn-group">
                <g:link class="btn btn-outline-secondary" action="edit" id="${competence?.id}">
                    <i class="fas fa-edit"></i> Bearbeiten
                </g:link>
                <g:link class="btn btn-outline-danger" action="delete" id="${competence?.id}"
                        onclick="return confirm('Sind Sie sicher, dass Sie diese Kompetenz löschen möchten?')">
                    <i class="fas fa-trash"></i> Löschen
                </g:link>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-info-circle"></i> Kompetenz Information</h5>
            </div>

            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <dl class="row">
                            <dt class="col-sm-4">ID:</dt>
                            <dd class="col-sm-8">${competence?.id}</dd>

                            <dt class="col-sm-4">Name:</dt>
                            <dd class="col-sm-8"><strong>${competence?.competenceName}</strong></dd>

                            <dt class="col-sm-4">Bewertungsskala:</dt>
                            <dd class="col-sm-8">
                                <span class="badge bg-info">${competence?.ratingScale?.ratingScaleName}</span>
                            </dd>

                            <dt class="col-sm-4">Status:</dt>
                            <dd class="col-sm-8">
                                <g:if test="${competence?.competenceActive}">
                                    <span class="badge bg-success">Aktiv</span>
                                </g:if>
                                <g:else>
                                    <span class="badge bg-secondary">Inaktiv</span>
                                </g:else>
                            </dd>
                        </dl>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h6>Verfügbare Bewertungen</h6>
                            </div>

                            <div class="card-body">
                                <g:if test="${competence?.ratingScale}">
                                    <g:each in="${competence.ratingScale.ratings?.sort { it.sortOrder }}" var="rating">
                                        <span class="badge bg-secondary me-1">${rating.ratingName} (${rating.points ?: 'N/A'})</span>
                                    </g:each>
                                </g:if>
                                <g:else>
                                    <p class="text-muted">Keine Bewertungsskala zugewiesen.</p>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Verwendung in MABs -->
        <div class="card mt-4">
            <div class="card-header">
                <h5><i class="fas fa-clipboard-list"></i> Verwendung in MAB-Formularen</h5>
            </div>

            <div class="card-body">
                <g:set var="mabCompetences" value="${MABCompetence.findAllByCompetence(competence)}"/>
                <g:if test="${mabCompetences}">
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>MAB ID</th>
                                <th>Beurteilungszeitraum</th>
                                <th>Status</th>
                                <th>Bewertung</th>
                                <th>Aktionen</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mabCompetences}" var="mabComp">
                                <tr>
                                    <td>${mabComp.mab.id}</td>
                                    <td>
                                        <g:formatDate date="${mabComp.mab.assessmentFrom}" format="dd.MM.yyyy"/> -
                                        <g:formatDate date="${mabComp.mab.assessmentTo}" format="dd.MM.yyyy"/>
                                    </td>
                                    <td><span class="badge bg-info">${mabComp.mab.mabStatus}</span></td>
                                    <td>
                                        <g:if test="${mabComp.rating}">
                                            <span class="badge bg-primary">${mabComp.rating.ratingName}</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-secondary">Nicht bewertet</span>
                                        </g:else>
                                    </td>
                                    <td>
                                        <g:link controller="mAB" action="show" id="${mabComp.mab.id}"
                                                class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye"></i>
                                        </g:link>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </g:if>
                <g:else>
                    <p class="text-muted">Diese Kompetenz wird derzeit in keinem MAB-Formular verwendet.</p>
                </g:else>
            </div>
        </div>
    </div>
</div>
</body>
</html>