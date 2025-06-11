<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'mab.label', default: 'MAB')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <h1><i class="fas fa-clipboard-list"></i> MAB Verwaltung</h1>

        <!-- Search and Filter Section -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-search"></i> Suchen & Filtern</h5>
            </div>
            <div class="card-body">
                <g:form action="index" method="GET" class="row g-3">
                    <div class="col-md-4">
                        <label for="search" class="form-label">Suchbegriff</label>
                        <g:textField name="search"
                                     value="${searchParams?.search}"
                                     class="form-control"
                                     placeholder="Kommentar, Status..." />
                    </div>
                    <div class="col-md-3">
                        <label for="status" class="form-label">Status</label>
                        <g:select name="status"
                                  from="${mabStatuses}"
                                  optionKey="id"
                                  optionValue="mabStatusName"
                                  value="${searchParams?.status}"
                                  class="form-select"
                                  noSelection="['': 'Alle Status']" />
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <g:submitButton name="submit" class="btn btn-primary me-2" value="Suchen" />
                        <g:link action="index" class="btn btn-outline-secondary">Reset</g:link>
                    </div>
                    <div class="col-md-3 d-flex align-items-end justify-content-end">
                        <g:link class="btn btn-success" action="create">
                            <i class="fas fa-plus"></i> Neue MAB erstellen
                        </g:link>
                    </div>
                </g:form>
            </div>
        </div>

        <!-- Results Summary -->
        <div class="alert alert-info">
            <g:if test="${searchParams?.search || searchParams?.status}">
                <strong>Suchergebnisse:</strong> ${mabList?.size()} von ${mabCount} MAB-Einträgen
                <g:if test="${searchParams?.search}">
                    für "<em>${searchParams.search}</em>"
                </g:if>
                <g:if test="${searchParams?.status}">
                    mit Status "<em>${mabStatuses.find{it.id.toString() == searchParams.status}?.mabStatusName}</em>"
                </g:if>
            </g:if>
            <g:else>
                <strong>Gesamt:</strong> ${mabCount} MAB-Einträge
            </g:else>
        </div>

        <!-- MAB List Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span>Mitarbeiterbeurteilungen</span>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-sm btn-outline-info dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="fas fa-download"></i> Export
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" onclick="window.print()">
                            <i class="fas fa-print"></i> Drucken
                        </a></li>
                        <li><a class="dropdown-item" href="#" onclick="exportToCSV()">
                            <i class="fas fa-file-csv"></i> CSV Export
                        </a></li>
                    </ul>
                </div>
            </div>

            <div class="card-body">
                <g:if test="${mabList}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover" id="mabTable">
                            <thead class="table-dark">
                            <tr>
                                <th><i class="fas fa-hashtag"></i> ID</th>
                                <th><i class="fas fa-calendar"></i> Beurteilungszeitraum</th>
                                <th><i class="fas fa-tasks"></i> Status</th>
                                <th><i class="fas fa-star"></i> Kompetenzen</th>
                                <th><i class="fas fa-users"></i> Beteiligte</th>
                                <th><i class="fas fa-globe"></i> Online</th>
                                <th><i class="fas fa-clock"></i> Erstellt</th>
                                <th><i class="fas fa-cogs"></i> Aktionen</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mabList}" var="mab" status="i">
                                <tr class="mab-row" data-mab-id="${mab.id}">
                                    <td><span class="badge bg-secondary">${mab.id}</span></td>
                                    <td>
                                        <small class="text-muted">von</small><br>
                                        <strong><g:formatDate date="${mab.assessmentFrom}" format="dd.MM.yyyy" /></strong><br>
                                        <small class="text-muted">bis</small><br>
                                        <strong><g:formatDate date="${mab.assessmentTo}" format="dd.MM.yyyy" /></strong>
                                    </td>
                                    <td>
                                        <g:set var="statusClass" value="${getStatusBadgeClass(mab.mabStatus.mabStatusName)}" />
                                        <span class="badge ${statusClass}">${mab.mabStatus.mabStatusName}</span>
                                        <br><small class="text-muted">
                                        <g:formatDate date="${mab.createDate}" format="dd.MM.yyyy" />
                                    </small>
                                    </td>
                                    <td>
                                        <g:set var="competenceCount" value="${mab.mabCompetences?.size() ?: 0}" />
                                        <span class="badge bg-info">${competenceCount}</span>
                                        <small class="text-muted">zugewiesen</small>
                                        <g:if test="${competenceCount > 0}">
                                            <br><small class="text-success">
                                            ${mab.mabCompetences?.count{it.rating != null} ?: 0} bewertet
                                        </small>
                                        </g:if>
                                    </td>
                                    <td>
                                        <g:set var="roleCount" value="${mab.mabRoles?.size() ?: 0}" />
                                        <span class="badge bg-secondary">${roleCount}</span>
                                        <g:if test="${roleCount > 0}">
                                            <br><small class="text-muted">
                                            ${mab.mabRoles?.collect{it.role.roleName}.join(', ')}
                                        </small>
                                        </g:if>
                                    </td>
                                    <td>
                                        <g:if test="${mab.isOnlineApproval}">
                                            <span class="badge bg-success"><i class="fas fa-check"></i> Ja</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-secondary"><i class="fas fa-times"></i> Nein</span>
                                        </g:else>
                                    </td>
                                    <td>
                                        <g:formatDate date="${mab.createDate}" format="dd.MM.yyyy" /><br>
                                        <small class="text-muted">
                                            <g:formatDate date="${mab.createDate}" format="HH:mm" />
                                        </small>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <g:link class="btn btn-sm btn-outline-primary" action="show" id="${mab.id}"
                                                    title="Anzeigen">
                                                <i class="fas fa-eye"></i>
                                            </g:link>
                                            <g:link class="btn btn-sm btn-outline-secondary" action="edit" id="${mab.id}"
                                                    title="Bearbeiten">
                                                <i class="fas fa-edit"></i>
                                            </g:link>
                                            <g:link class="btn btn-sm btn-outline-success" action="addCompetence" id="${mab.id}"
                                                    title="Kompetenz hinzufügen">
                                                <i class="fas fa-star"></i>
                                            </g:link>
                                            <button class="btn btn-sm btn-outline-danger"
                                                    onclick="confirmDelete(${mab.id})"
                                                    title="Löschen">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <nav aria-label="MAB pagination">
                        <g:paginate total="${mabCount ?: 0}" params="${searchParams}" />
                    </nav>
                </g:if>
                <g:else>
                    <div class="alert alert-info text-center">
                        <i class="fas fa-info-circle fa-2x mb-3"></i>
                        <h5>Keine MAB-Einträge gefunden</h5>
                        <p class="mb-3">
                            <g:if test="${searchParams?.search || searchParams?.status}">
                                Ihre Suchkriterien ergaben keine Treffer.
                            </g:if>
                            <g:else>
                                Noch keine MAB-Einträge vorhanden.
                            </g:else>
                        </p>
                        <g:link action="create" class="btn btn-success">
                            <i class="fas fa-plus"></i> Erste MAB erstellen
                        </g:link>
                    </div>
                </g:else>
            </div>
        </div>

    <!-- Statistics Card -->
        <g:if test="${mabList}">
            <div class="row mt-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-clipboard-list"></i> Gesamt MABs</h5>
                            <h2>${mabCount}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-clock"></i> In Bearbeitung</h5>
                            <h2>${mabList?.count{it.mabStatus.mabStatusName.contains('Bewertung')} ?: 0}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-info">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-users"></i> MA-Gespräch</h5>
                            <h2>${mabList?.count{it.mabStatus.mabStatusName.contains('Gespräch')} ?: 0}</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-check"></i> Abgeschlossen</h5>
                            <h2>${mabList?.count{it.mabStatus.mabStatusName.contains('abgeschlossen')} ?: 0}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </g:if>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">MAB löschen</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                Sind Sie sicher, dass Sie diese MAB löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Abbrechen</button>
                <g:form action="delete" method="DELETE" style="display: inline;">
                    <g:hiddenField name="id" value="" id="deleteId" />
                    <button type="submit" class="btn btn-danger">Löschen</button>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(mabId) {
        document.getElementById('deleteId').value = mabId;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    function exportToCSV() {
        const table = document.getElementById('mabTable');
        let csv = [];
        const rows = table.querySelectorAll('tr');

        for (let i = 0; i < rows.length; i++) {
            const row = [], cols = rows[i].querySelectorAll('td, th');

            for (let j = 0; j < cols.length - 1; j++) { // Skip actions column
                row.push('"' + cols[j].innerText.replace(/"/g, '""') + '"');
            }

            csv.push(row.join(','));
        }

        const csvFile = new Blob([csv.join('\n')], {type: 'text/csv'});
        const downloadLink = document.createElement('a');
        downloadLink.download = 'mab_export.csv';
        downloadLink.href = window.URL.createObjectURL(csvFile);
        downloadLink.style.display = 'none';
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink);
    }

    // Helper function for status badge classes (to be added to a TagLib or helper)
    function getStatusBadgeClass(statusName) {
        if (statusName?.contains('Bewertung')) return 'bg-warning';
        if (statusName?.contains('Freigabe')) return 'bg-info';
        if (statusName?.contains('Gespräch')) return 'bg-primary';
        if (statusName?.contains('Signieren')) return 'bg-secondary';
        if (statusName?.contains('abgeschlossen')) return 'bg-success';
        return 'bg-secondary';
    }
</script>

<style>
.mab-row:hover {
    background-color: #f8f9fa !important;
}

.table th {
    vertical-align: middle;
    font-size: 0.9rem;
}

.table td {
    vertical-align: middle;
    font-size: 0.85rem;
}

.badge {
    font-size: 0.75rem;
}

.card {
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}
</style>
</body>
</html>