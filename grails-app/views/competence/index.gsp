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
    <g:set var="entityName" value="${message(code: 'competence.label', default: 'Competence')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <h1><i class="fas fa-star"></i> Kompetenzkatalog</h1>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span>Verfügbare Kompetenzen (${competenceCount} Einträge)</span>
                <g:link class="btn btn-success" action="create">
                    <i class="fas fa-plus"></i> Neue Kompetenz erstellen
                </g:link>
            </div>

            <div class="card-body">
                <g:if test="${competenceList}">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th><g:message code="competence.id.label" default="ID" /></th>
                                <th>Kompetenzname</th>
                                <th>Bewertungsskala</th>
                                <th>Status</th>
                                <th>Aktionen</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${competenceList}" var="competence">
                                <tr class="${competence.competenceActive ? '' : 'table-secondary'}">
                                    <td>${competence.id}</td>
                                    <td>
                                        <strong>${competence.competenceName}</strong>
                                    </td>
                                    <td>
                                        <span class="badge bg-info">${competence.ratingScale}</span>
                                    </td>
                                    <td>
                                        <g:if test="${competence.competenceActive}">
                                            <span class="badge bg-success">Aktiv</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-secondary">Inaktiv</span>
                                        </g:else>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <g:link class="btn btn-sm btn-outline-primary" action="show" id="${competence.id}">
                                                <i class="fas fa-eye"></i>
                                            </g:link>
                                            <g:link class="btn btn-sm btn-outline-secondary" action="edit" id="${competence.id}">
                                                <i class="fas fa-edit"></i>
                                            </g:link>
                                            <g:form action="delete" id="${competence.id}" method="DELETE" style="display: inline;">
                                                <button type="submit" class="btn btn-sm btn-outline-danger"
                                                        onclick="return confirm('Sind Sie sicher, dass Sie diese Kompetenz löschen möchten?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </g:form>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination">
                        <g:paginate total="${competenceCount ?: 0}" />
                    </div>
                </g:if>
                <g:else>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Noch keine Kompetenzen vorhanden.
                        <g:link action="create">Erstellen Sie die erste Kompetenz.</g:link>
                    </div>
                </g:else>
            </div>
        </div>
    </div>
</div>
</body>
</html>