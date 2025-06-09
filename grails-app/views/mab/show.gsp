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
            <h1><i class="fas fa-clipboard-list"></i> MAB Details #${mAB?.id}</h1>
            <div class="btn-group">
                <g:link class="btn btn-outline-secondary" action="edit" id="${mAB?.id}">
                    <i class="fas fa-edit"></i> Bearbeiten
                </g:link>
                <g:link class="btn btn-outline-success" action="addCompetence" id="${mAB?.id}">
                    <i class="fas fa-star"></i> Kompetenz hinzufügen
                </g:link>
                <g:link class="btn btn-outline-info" action="addRole" id="${mAB?.id}">
                    <i class="fas fa-user-plus"></i> Person hinzufügen
                </g:link>
            </div>
        </div>

        <!-- Workflow Status Card -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5><i class="fas fa-project-diagram"></i> Workflow Status</h5>
            </div>
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <!-- Workflow Progress Bar -->
                        <div class="workflow-container">
                            <g:set var="statuses" value="${['Bewertung Vorgesetzter', 'Freigabe Supervisor', 'MA-Gespräch', 'MAB Signieren', 'MAB abgeschlossen']}" />
                            <g:set var="currentStatusIndex" value="${statuses.findIndexOf { it == mAB?.mabStatus?.mabStatusName }}" />

                            <div class="d-flex justify-content-between position-relative">
                                <div class="progress workflow-progress">
                                    <div class="progress-bar bg-success"
                                         style="width: ${(currentStatusIndex + 1) * 20}%"></div>
                                </div>

                                <g:each in="${statuses}" var="status" status="i">
                                    <div class="workflow-step ${i <= currentStatusIndex ? 'completed' : 'pending'}">
                                        <div class="step-circle">
                                            <g:if test="${i <= currentStatusIndex}">
                                                <i class="fas fa-check"></i>
                                            </g:if>
                                            <g:else>
                                                ${i + 1}
                                            </g:else>
                                        </div>
                                        <div class="step-label">${status}</div>
                                    </div>
                                </g:each>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="current-status">
                            <h6>Aktueller Status:</h6>
                            <span class="badge bg-primary fs-6">${mAB?.mabStatus?.mabStatusName}</span>

                        <!-- Status Change Form -->
                            <g:form action="updateStatus" class="mt-3">
                                <g:hiddenField name="mabId" value="${mAB?.id}" />
                                <div class="input-group input-group-sm">
                                    <g:select name="statusId"
                                              from="${MABStatus.list()}"
                                              optionKey="id"
                                              optionValue="mabStatusName"
                                              value="${mAB?.mabStatus?.id}"
                                              class="form-select" />
                                    <g:submitButton name="updateStatus" class="btn btn-outline-primary" value="Ändern" />
                                </div>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-8">
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
                                    <dd class="col-sm-8"><span class="badge bg-secondary">${mAB?.id}</span></dd>

                                    <dt class="col-sm-4">Beurteilungszeitraum:</dt>
                                    <dd class="col-sm-8">
                                        <i class="fas fa-calendar-alt text-muted"></i>
                                        <g:formatDate date="${mAB?.assessmentFrom}" format="dd.MM.yyyy" /> -
                                        <g:formatDate date="${mAB?.assessmentTo}" format="dd.MM.yyyy" />
                                        <br><small class="text-muted">
                                        <g:set var="duration" value="${(mAB?.assessmentTo?.time - mAB?.assessmentFrom?.time) / (1000 * 60 * 60 * 24)}" />
                                        ${Math.round(duration)} Tage
                                    </small>
                                    </dd>

                                    <dt class="col-sm-4">Online Freigabe:</dt>
                                    <dd class="col-sm-8">
                                        <g:if test="${mAB?.isOnlineApproval}">
                                            <span class="badge bg-success"><i class="fas fa-check"></i> Ja</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-secondary"><i class="fas fa-times"></i> Nein</span>
                                        </g:else>
                                    </dd>

                                    <dt class="col-sm-4">Erstellt am:</dt>
                                    <dd class="col-sm-8">
                                        <i class="fas fa-clock text-muted"></i>
                                        <g:formatDate date="${mAB?.createDate}" format="dd.MM.yyyy HH:mm" />
                                    </dd>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                <g:if test="${mAB?.commentText}">
                                    <h6><i class="fas fa-comment"></i> Allgemeiner Kommentar:</h6>
                                    <div class="border rounded p-3 bg-light">
                                        <p class="mb-0">${mAB?.commentText}</p>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="text-muted text-center p-4">
                                        <i class="fas fa-comment-slash fa-2x"></i>
                                        <p class="mt-2">Kein allgemeiner Kommentar</p>
                                    </div>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bewertete Kompetenzen -->
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5><i class="fas fa-star"></i> Bewertete Kompetenzen (${mAB?.mabCompetences?.size() ?: 0})</h5>
                        <g:link class="btn btn-sm btn-success" action="addCompetence" id="${mAB?.id}">
                            <i class="fas fa-plus"></i> Kompetenz hinzufügen
                        </g:link>
                    </div>
                    <div class="card-body">
                        <g:if test="${mAB?.mabCompetences}">
                            <div class="row">
                                <g:each in="${mAB.mabCompetences}" var="comp" status="i">
                                    <div class="col-md-6 mb-3">
                                        <div class="card h-100 competence-card">
                                            <div class="card-header d-flex justify-content-between align-items-start">
                                                <h6 class="card-title mb-0">${comp.competence.competenceName}</h6>
                                                <g:if test="${comp.rating}">
                                                    <span class="badge bg-primary">
                                                        ${comp.rating.ratingName}
                                                        <g:if test="${comp.rating.points}">
                                                            (${comp.rating.points} Pkt.)
                                                        </g:if>
                                                    </span>
                                                </g:if>
                                                <g:else>
                                                    <span class="badge bg-secondary">Nicht bewertet</span>
                                                </g:else>
                                            </div>
                                            <div class="card-body">
                                                <g:if test="${comp.descriptionText}">
                                                    <p class="card-text">
                                                        <strong>Beschreibung:</strong><br>
                                                        <small>${comp.descriptionText}</small>
                                                    </p>
                                                </g:if>

                                                <g:if test="${comp.assessmentText}">
                                                    <p class="card-text">
                                                        <strong>Bewertungskommentar:</strong><br>
                                                        <small class="text-muted">${comp.assessmentText}</small>
                                                    </p>
                                                </g:if>

                                            <!-- Rating Scale Info -->
                                                <div class="mt-2">
                                                    <small class="text-muted">
                                                        <i class="fas fa-ruler"></i> Skala: ${comp.competence.ratingScale.ratingScaleName}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </g:each>
                            </div>

                            <!-- Competence Summary -->
                            <div class="mt-3 p-3 bg-light rounded">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h6 class="mb-0">${mAB.mabCompetences.size()}</h6>
                                        <small class="text-muted">Zugewiesen</small>
                                    </div>
                                    <div class="col-4">
                                        <h6 class="mb-0 text-success">${mAB.mabCompetences.count{it.rating != null}}</h6>
                                        <small class="text-muted">Bewertet</small>
                                    </div>
                                    <div class="col-4">
                                        <h6 class="mb-0 text-warning">${mAB.mabCompetences.count{it.rating == null}}</h6>
                                        <small class="text-muted">Offen</small>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle fa-2x mb-3"></i>
                                <h5>Noch keine Kompetenzen zugewiesen</h5>
                                <p>Fügen Sie Kompetenzen aus dem Katalog hinzu, um mit der Bewertung zu beginnen.</p>
                                <g:link action="addCompetence" id="${mAB?.id}" class="btn btn-success">
                                    <i class="fas fa-plus"></i> Erste Kompetenz hinzufügen
                                </g:link>
                            </div>
                        </g:else>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-lg-4">
                <!-- Beteiligte Personen -->
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5><i class="fas fa-users"></i> Beteiligte Personen</h5>
                        <g:link class="btn btn-sm btn-outline-primary" action="addRole" id="${mAB?.id}">
                            <i class="fas fa-user-plus"></i>
                        </g:link>
                    </div>
                    <div class="card-body">
                        <g:if test="${mAB?.mabRoles}">
                            <g:each in="${mAB.mabRoles}" var="role">
                                <div class="person-item mb-3 p-3 border rounded">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="person-info">
                                            <h6 class="mb-1">${role.firstName} ${role.lastName}</h6>
                                            <span class="badge bg-secondary mb-2">${role.role.roleName}</span>
                                            <g:if test="${role.mail}">
                                                <br><small class="text-muted">
                                                <i class="fas fa-envelope"></i> ${role.mail}
                                            </small>
                                            </g:if>
                                        </div>
                                        <div class="approval-status">
                                            <g:if test="${role.hasApproved}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check"></i> Freigegeben
                                                </span>
                                                <g:if test="${role.approvedDate}">
                                                    <br><small class="text-muted">
                                                    <g:formatDate date="${role.approvedDate}" format="dd.MM.yyyy" />
                                                </small>
                                                </g:if>
                                            </g:if>
                                            <g:else>
                                                <span class="badge bg-warning">Ausstehend</span>
                                            </g:else>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </g:if>
                        <g:else>
                            <div class="text-center text-muted p-3">
                                <i class="fas fa-user-slash fa-2x mb-2"></i>
                                <p>Keine Personen zugewiesen</p>
                                <g:link action="addRole" id="${mAB?.id}" class="btn btn-sm btn-outline-primary">
                                    Person hinzufügen
                                </g:link>
                            </div>
                        </g:else>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5><i class="fas fa-bolt"></i> Schnellaktionen</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <g:link class="btn btn-outline-primary" action="edit" id="${mAB?.id}">
                                <i class="fas fa-edit"></i> MAB bearbeiten
                            </g:link>
                            <g:link class="btn btn-outline-success" action="addCompetence" id="${mAB?.id}">
                                <i class="fas fa-star"></i> Kompetenz hinzufügen
                            </g:link>
                            <g:link class="btn btn-outline-info" action="addRole" id="${mAB?.id}">
                                <i class="fas fa-user-plus"></i> Person hinzufügen
                            </g:link>
                            <button class="btn btn-outline-secondary" onclick="window.print()">
                                <i class="fas fa-print"></i> Drucken
                            </button>
                            <button class="btn btn-outline-danger" onclick="confirmDelete(${mAB?.id})">
                                <i class="fas fa-trash"></i> Löschen
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Kommentare -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-comments"></i> Kommentare & Feedback</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="comment-section">
                            <h6><i class="fas fa-user"></i> Mitarbeiter-Kommentar:</h6>
                            <div class="border rounded p-3 bg-light">
                                <g:if test="${mAB?.appraiseeComment}">
                                    <p class="mb-0">${mAB?.appraiseeComment}</p>
                                </g:if>
                                <g:else>
                                    <em class="text-muted">Kein Kommentar</em>
                                </g:else>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="comment-section">
                            <h6><i class="fas fa-user-tie"></i> Vorgesetzter-Kommentar:</h6>
                            <div class="border rounded p-3 bg-light">
                                <g:if test="${mAB?.supervisorComment}">
                                    <p class="mb-0">${mAB?.supervisorComment}</p>
                                </g:if>
                                <g:else>
                                    <em class="text-muted">Kein Kommentar</em>
                                </g:else>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="comment-section">
                            <h6><i class="fas fa-building"></i> HR-Kommentar:</h6>
                            <div class="border rounded p-3 bg-light">
                                <g:if test="${mAB?.hrComment}">
                                    <p class="mb-0">${mAB?.hrComment}</p>
                                </g:if>
                                <g:else>
                                    <em class="text-muted">Kein Kommentar</em>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.workflow-container {
    position: relative;
    padding: 20px 0;
}

.workflow-progress {
    position: absolute;
    top: 30px;
    left: 0;
    right: 0;
    height: 4px;
    z-index: 1;
}

.workflow-step {
    position: relative;
    z-index: 2;
    text-align: center;
    flex: 1;
}

.step-circle {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 10px;
    font-weight: bold;
    color: white;
}

.workflow-step.completed .step-circle {
    background-color: #28a745;
}

.workflow-step.pending .step-circle {
    background-color: #6c757d;
}

.step-label {
    font-size: 0.8rem;
    font-weight: 500;
    max-width: 100px;
    margin: 0 auto;
}

.competence-card {
    transition: transform 0.2s;
}

.competence-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.person-item {
    transition: background-color 0.2s;
}

.person-item:hover {
    background-color: #f8f9fa;
}

.comment-section {
    margin-bottom: 1rem;
}

@media print {
    .btn, .btn-group, .card-header .btn {
        display: none !important;
    }
}
</style>

<script>
    function confirmDelete(mabId) {
        if (confirm('Sind Sie sicher, dass Sie diese MAB löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${createLink(action: "delete")}';

            const hiddenField = document.createElement('input');
            hiddenField.type = 'hidden';
            hiddenField.name = 'id';
            hiddenField.value = mabId;
            form.appendChild(hiddenField);

            const methodField = document.createElement('input');
            methodField.type = 'hidden';
            methodField.name = '_method';
            methodField.value = 'DELETE';
            form.appendChild(methodField);

            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>