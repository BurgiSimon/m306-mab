<%--
  Created by IntelliJ IDEA.
  User: simon
  Date: 6/3/25
  Time: 10:40 AM
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'mAB.label', default: 'MAB')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">MAB Verwaltung</g:link></li>
                <li class="breadcrumb-item active">MAB ${mAB?.id}</li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1><i class="fas fa-clipboard-list"></i> MAB Details</h1>
            <div class="btn-group">
                <g:link class="btn btn-outline-secondary" action="edit" id="${mAB?.id}">
                    <i class="fas fa-edit"></i> Bearbeiten
                </g:link>
                <g:link class="btn btn-outline-success" action="addCompetence" id="${mAB?.id}">
                    <i class="fas fa-star"></i> Kompetenz hinzufügen
                </g:link>
            </div>
        </div>

        <!-- MAB Grunddaten -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-info-circle"></i> Grunddaten</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <dl class="row">
                            <dt class="col-sm-4">ID:</dt>
                            <dd class="col-sm-8">${mAB?.id}</dd>

                            <dt class="col-sm-4">Status:</dt>
                            <dd class="col-sm-8">
                                <span class="badge bg-info">${mAB?.mabStatus}</span>
                            </dd>

                            <dt class="col-sm-4">Beurteilungszeitraum:</dt>
                            <dd class="col-sm-8">
                                <g:formatDate date="${mAB?.assessmentFrom}" format="dd.MM.yyyy" /> -
                                <g:formatDate date="${mAB?.assessmentTo}" format="dd.MM.yyyy" />
                            </dd>

                            <dt class="col-sm-4">Online Freigabe:</dt>
                            <dd class="col-sm-8">
                                <g:if test="${mAB?.isOnlineApproval}">
                                    <span class="badge bg-success">Ja</span>
                                </g:if>
                                <g:else>
                                    <span class="badge bg-secondary">Nein</span>
                                </g:else>
                            </dd>

                            <dt class="col-sm-4">Erstellt am:</dt>
                            <dd class="col-sm-8">
                                <g:formatDate date="${mAB?.createDate}" format="dd.MM.yyyy HH:mm" />
                            </dd>
                        </dl>
                    </div>
                    <div class="col-md-6">
                        <g:if test="${mAB?.commentText}">
                            <h6>Kommentar:</h6>
                            <p class="text-muted">${mAB?.commentText}</p>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Beteiligte Personen -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-users"></i> Beteiligte Personen</h5>
            </div>
            <div class="card-body">
                <g:if test="${mAB?.mabRoles}">
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Rolle</th>
                                <th>E-Mail</th>
                                <th>Freigabe</th>
                                <th>Freigabe Datum</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mAB.mabRoles}" var="role">
                                <tr>
                                    <td>${role.firstName} ${role.lastName}</td>
                                    <td><span class="badge bg-secondary">${role.role}</span></td>
                                    <td>${role.mail}</td>
                                    <td>
                                        <g:if test="${role.hasApproved}">
                                            <span class="badge bg-success">Freigegeben</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-warning">Ausstehend</span>
                                        </g:else>
                                    </td>
                                    <td>
                                        <g:if test="${role.approvedDate}">
                                            <g:formatDate date="${role.approvedDate}" format="dd.MM.yyyy" />
                                        </g:if>
                                        <g:else>-</g:else>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </g:if>
                <g:else>
                    <p class="text-muted">Keine Personen zugewiesen.</p>
                </g:else>
            </div>
        </div>

        <!-- Bewertete Kompetenzen -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5><i class="fas fa-star"></i> Bewertete Kompetenzen</h5>
                <g:link class="btn btn-sm btn-success" action="addCompetence" id="${mAB?.id}">
                    <i class="fas fa-plus"></i> Kompetenz hinzufügen
                </g:link>
            </div>
            <div class="card-body">
                <g:if test="${mAB?.mabCompetences}">
                    <div class="row">
                        <g:each in="${mAB.mabCompetences}" var="comp">
                            <div class="col-md-6 mb-3">
                                <div class="card border-left-primary">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <h6 class="card-title">${comp.competence.competenceName}</h6>
                                            <g:if test="${comp.rating}">
                                                <span class="badge bg-primary">${comp.rating.ratingName} (${comp.rating.points})</span>
                                            </g:if>
                                            <g:else>
                                                <span class="badge bg-secondary">Nicht bewertet</span>
                                            </g:else>
                                        </div>

                                        <g:if test="${comp.descriptionText}">
                                            <p class="card-text"><strong>Beschreibung:</strong> ${comp.descriptionText}</p>
                                        </g:if>

                                        <g:if test="${comp.assessmentText}">
                                            <p class="card-text"><strong>Bewertung:</strong> ${comp.assessmentText}</p>
                                        </g:if>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </g:if>
                <g:else>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Noch keine Kompetenzen zugewiesen.
                        <g:link action="addCompetence" id="${mAB?.id}">Fügen Sie die erste Kompetenz hinzu.</g:link>
                    </div>
                </g:else>
            </div>
        </div>

        <!-- Kommentare -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-comments"></i> Kommentare</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <h6>Mitarbeiter-Kommentar:</h6>
                        <p class="text-muted">${mAB?.appraiseeComment ?: 'Kein Kommentar'}</p>
                    </div>
                    <div class="col-md-4">
                        <h6>Vorgesetzter-Kommentar:</h6>
                        <p class="text-muted">${mAB?.supervisorComment ?: 'Kein Kommentar'}</p>
                    </div>
                    <div class="col-md-4">
                        <h6>HR-Kommentar:</h6>
                        <p class="text-muted">${mAB?.hrComment ?: 'Kein Kommentar'}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>