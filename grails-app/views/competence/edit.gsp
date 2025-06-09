<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'competence.label', default: 'Competence')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">Kompetenzkatalog</g:link></li>
                <li class="breadcrumb-item"><g:link action="show" id="${competence?.id}">Kompetenz ${competence?.id}</g:link></li>
                <li class="breadcrumb-item active">Bearbeiten</li>
            </ol>
        </nav>

        <h1><i class="fas fa-edit"></i> Kompetenz bearbeiten</h1>

        <g:hasErrors bean="${competence}">
            <div class="alert alert-danger">
                <g:renderErrors bean="${competence}" as="list" />
            </div>
        </g:hasErrors>

        <div class="card">
            <div class="card-body">
                <g:form resource="${competence}" method="PUT" class="needs-validation" novalidate="true">
                    <g:hiddenField name="version" value="${competence?.version}" />
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="competenceName" class="form-label">Kompetenzname <span class="text-danger">*</span></label>
                                <g:textField name="competenceName"
                                             value="${competence?.competenceName}"
                                             class="form-control"
                                             maxlength="50"
                                             required="true"
                                             placeholder="z.B. Fachliche Kompetenz" />
                            </div>

                            <div class="mb-3">
                                <label for="ratingScale" class="form-label">Bewertungsskala <span class="text-danger">*</span></label>
                                <g:select name="ratingScale.id"
                                          from="${ratingScales}"
                                          optionKey="id"
                                          optionValue="ratingScaleName"
                                          value="${competence?.ratingScale?.id}"
                                          class="form-select"
                                          required="true"
                                          noSelection="['': '-- Bewertungsskala auswählen --']" />
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <g:checkBox name="competenceActive"
                                                value="${competence?.competenceActive}"
                                                class="form-check-input" />
                                    <label class="form-check-label" for="competenceActive">
                                        Kompetenz ist aktiv
                                    </label>
                                    <div class="form-text">Inaktive Kompetenzen können nicht neuen MAB-Formularen zugewiesen werden.</div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="alert alert-info">
                                <h6><i class="fas fa-info-circle"></i> Hinweise zur Kompetenz-Bearbeitung</h6>
                                <ul class="mb-0">
                                    <li><strong>Kompetenzname:</strong> Sollte aussagekräftig und eindeutig sein</li>
                                    <li><strong>Bewertungsskala:</strong> Bestimmt die verfügbaren Bewertungsoptionen</li>
                                    <li><strong>Status:</strong> Nur aktive Kompetenzen können neuen MABs zugewiesen werden</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <g:submitButton name="update" class="btn btn-success" value="Änderungen speichern" />
                        <g:link class="btn btn-secondary" action="show" id="${competence?.id}">Abbrechen</g:link>
                        <g:link class="btn btn-outline-danger" action="delete" id="${competence?.id}"
                                onclick="return confirm('Sind Sie sicher, dass Sie diese Kompetenz löschen möchten?')">
                            <i class="fas fa-trash"></i> Löschen
                        </g:link>
                    </div>
                </g:form>
            </div>
        </div>
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
</script>
</body>
</html>