<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Person zu MAB hinzufügen</title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">MAB Verwaltung</g:link></li>
                <li class="breadcrumb-item"><g:link action="show" id="${mAB?.id}">MAB ${mAB?.id}</g:link></li>
                <li class="breadcrumb-item active">Person hinzufügen</li>
            </ol>
        </nav>

        <h1><i class="fas fa-user-plus"></i> Person zu MAB hinzufügen</h1>

        <div class="card">
            <div class="card-header">
                <h5>MAB Details</h5>
            </div>
            <div class="card-body">
                <dl class="row">
                    <dt class="col-sm-3">Beurteilungszeitraum:</dt>
                    <dd class="col-sm-9">
                        <g:formatDate date="${mAB?.assessmentFrom}" format="dd.MM.yyyy" /> -
                        <g:formatDate date="${mAB?.assessmentTo}" format="dd.MM.yyyy" />
                    </dd>
                    <dt class="col-sm-3">Status:</dt>
                    <dd class="col-sm-9"><span class="badge bg-info">${mAB?.mabStatus}</span></dd>
                </dl>
            </div>
        </div>

        <div class="card mt-4">
            <div class="card-header">
                <h5>Person hinzufügen</h5>
            </div>
            <div class="card-body">
                <g:form action="saveRole" class="needs-validation" novalidate="true">
                    <g:hiddenField name="mabId" value="${mAB?.id}" />

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="roleId" class="form-label">Rolle <span class="text-danger">*</span></label>
                                <g:select name="roleId"
                                          from="${roles}"
                                          optionKey="id"
                                          optionValue="roleName"
                                          class="form-select"
                                          required="true"
                                          noSelection="['': '-- Rolle auswählen --']" />
                            </div>

                            <div class="mb-3">
                                <label for="firstName" class="form-label">Vorname <span class="text-danger">*</span></label>
                                <g:textField name="firstName"
                                             class="form-control"
                                             maxlength="50"
                                             required="true"
                                             placeholder="Vorname der Person" />
                            </div>

                            <div class="mb-3">
                                <label for="lastName" class="form-label">Nachname <span class="text-danger">*</span></label>
                                <g:textField name="lastName"
                                             class="form-control"
                                             maxlength="50"
                                             required="true"
                                             placeholder="Nachname der Person" />
                            </div>

                            <div class="mb-3">
                                <label for="mail" class="form-label">E-Mail Adresse</label>
                                <g:emailField name="mail"
                                              class="form-control"
                                              maxlength="100"
                                              placeholder="vorname.nachname@firma.ch" />
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="empNum" class="form-label">Mitarbeiternummer</label>
                                <g:numberField name="empNum"
                                               class="form-control"
                                               placeholder="z.B. 12345" />
                            </div>

                            <div class="mb-3">
                                <label for="login" class="form-label">Login/Benutzername</label>
                                <g:textField name="login"
                                             class="form-control"
                                             maxlength="50"
                                             placeholder="Benutzername für System" />
                            </div>

                            <div class="alert alert-info">
                                <h6><i class="fas fa-info-circle"></i> Hinweise</h6>
                                <ul class="mb-0">
                                    <li><strong>Rolle:</strong> Bestimmt die Berechtigung und Funktion der Person</li>
                                    <li><strong>E-Mail:</strong> Wird für Benachrichtigungen verwendet</li>
                                    <li><strong>Mitarbeiternummer:</strong> Optional, zur eindeutigen Identifikation</li>
                                </ul>
                            </div>

                            <div class="card">
                                <div class="card-header">
                                    <h6>Verfügbare Rollen</h6>
                                </div>
                                <div class="card-body">
                                    <g:if test="${roles}">
                                        <g:each in="${roles}" var="role">
                                            <div class="mb-2">
                                                <strong>${role.roleName}</strong>
                                                <div class="text-muted small">
                                                    <g:if test="${role.roleName == 'Vorgesetzter'}">
                                                        Führt die Bewertung durch und erstellt Kommentare
                                                    </g:if>
                                                    <g:elseif test="${role.roleName == 'Mitarbeiter'}">
                                                        Wird beurteilt und kann Selbsteinschätzung abgeben
                                                    </g:elseif>
                                                    <g:elseif test="${role.roleName == 'Supervisor'}">
                                                        Überprüft und genehmigt die Bewertung
                                                    </g:elseif>
                                                    <g:elseif test="${role.roleName == 'HR'}">
                                                        Administrative Übersicht und finale Freigabe
                                                    </g:elseif>
                                                    <g:else>
                                                        Spezielle Rolle im MAB-Prozess
                                                    </g:else>
                                                </div>
                                            </div>
                                        </g:each>
                                    </g:if>
                                    <g:else>
                                        <p class="text-muted">Keine Rollen verfügbar.</p>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <g:submitButton name="save" class="btn btn-success" value="Person hinzufügen" />
                        <g:link class="btn btn-secondary" action="show" id="${mAB?.id}">Abbrechen</g:link>
                    </div>
                </g:form>
            </div>
        </div>

    <!-- Bereits zugewiesene Personen -->
        <g:if test="${mAB?.mabRoles}">
            <div class="card mt-4">
                <div class="card-header">
                    <h5>Bereits zugewiesene Personen</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Rolle</th>
                                <th>E-Mail</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mAB.mabRoles}" var="role">
                                <tr>
                                    <td>${role.firstName} ${role.lastName}</td>
                                    <td><span class="badge bg-secondary">${role.role.roleName}</span></td>
                                    <td>${role.mail ?: '-'}</td>
                                    <td>
                                        <g:if test="${role.hasApproved}">
                                            <span class="badge bg-success">Freigegeben</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-warning">Ausstehend</span>
                                        </g:else>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </g:if>
    </div>
</div>

<script>
    // Bootstrap form validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Auto-generate login from names
    document.addEventListener('DOMContentLoaded', function() {
        const firstNameField = document.querySelector('input[name="firstName"]');
        const lastNameField = document.querySelector('input[name="lastName"]');
        const loginField = document.querySelector('input[name="login"]');

        function generateLogin() {
            const firstName = firstNameField.value.trim();
            const lastName = lastNameField.value.trim();

            if (firstName && lastName && !loginField.value) {
                const login = (firstName.charAt(0) + lastName).toLowerCase()
                    .replace(/[^a-z0-9]/g, '');
                loginField.value = login;
            }
        }

        firstNameField.addEventListener('blur', generateLogin);
        lastNameField.addEventListener('blur', generateLogin);
    });
</script>
</body>
</html>