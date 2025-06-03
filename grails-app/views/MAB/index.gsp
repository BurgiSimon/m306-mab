<%--
  Created by IntelliJ IDEA.
  User: simon
  Date: 6/3/25
  Time: 10:39 AM
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'mAB.label', default: 'MAB')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <h1><i class="fas fa-clipboard-list"></i> MAB Verwaltung</h1>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span>Mitarbeiterbeurteilungen (${mABCount} Einträge)</span>
                <g:link class="btn btn-success" action="create">
                    <i class="fas fa-plus"></i> Neue MAB erstellen
                </g:link>
            </div>

            <div class="card-body">
                <g:if test="${mABList}">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th><g:message code="mAB.id.label" default="ID" /></th>
                                <th>Beurteilungszeitraum</th>
                                <th>Status</th>
                                <th>Online Freigabe</th>
                                <th>Erstellt am</th>
                                <th>Aktionen</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mABList}" var="mAB">
                                <tr>
                                    <td>${mAB.id}</td>
                                    <td>
                                        <g:formatDate date="${mAB.assessmentFrom}" format="dd.MM.yyyy" /> -
                                        <g:formatDate date="${mAB.assessmentTo}" format="dd.MM.yyyy" />
                                    </td>
                                    <td>
                                        <span class="badge bg-info">${mAB.mabStatus}</span>
                                    </td>
                                    <td>
                                        <g:if test="${mAB.isOnlineApproval}">
                                            <span class="badge bg-success">Ja</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-secondary">Nein</span>
                                        </g:else>
                                    </td>
                                    <td><g:formatDate date="${mAB.createDate}" format="dd.MM.yyyy HH:mm" /></td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <g:link class="btn btn-sm btn-outline-primary" action="show" id="${mAB.id}">
                                                <i class="fas fa-eye"></i>
                                            </g:link>
                                            <g:link class="btn btn-sm btn-outline-secondary" action="edit" id="${mAB.id}">
                                                <i class="fas fa-edit"></i>
                                            </g:link>
                                            <g:link class="btn btn-sm btn-outline-success" action="addCompetence" id="${mAB.id}">
                                                <i class="fas fa-star"></i>
                                            </g:link>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination">
                        <g:paginate total="${mABCount ?: 0}" />
                    </div>
                </g:if>
                <g:else>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Noch keine MAB-Einträge vorhanden.
                        <g:link action="create">Erstellen Sie die erste Mitarbeiterbeurteilung.</g:link>
                    </div>
                </g:else>
            </div>
        </div>
    </div>
</div>
</body>
</html>