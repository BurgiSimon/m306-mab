<%--
  Created by IntelliJ IDEA.
  User: simon
  Date: 6/3/25
  Time: 10:52 AM
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'competence.label', default: 'Competence')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">Kompetenzkatalog</g:link></li>
                <li class="breadcrumb-item active">Neue Kompetenz erstellen</li>
            </ol>
        </nav>

        <h1><i class="fas fa-plus"></i> Neue Kompetenz erstellen</h1>

        <g:hasErrors bean="${competence}">
            <div class="alert alert-danger">
                <g:renderErrors bean="${competence}" as="list" />
            </div>
        </g:hasErrors>

        <div class="card">
            <div class="card-body">
                <g:form action="save" class="needs-validation" novalidate="true">
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
                                                value="${competence?.competenceActive != null ? competence?.competenceActive : true}"
                                                class="form-check-input"
                                                checked="true" />
                                    <label class="form-check-label" for="competenceActive">
                                        Kompetenz ist aktiv
                                    </label>
                                    <div class="form-text">Inaktive Kompetenzen können nicht neuen MAB-Formularen zugewiesen werden.</div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="alert alert-info">
                                <h6><i class="fas fa-info-circle"></i> Hinweise zur Kompetenz-Erstellung</h6>
                                <ul class="mb-0">
                                    <li><strong>Kompetenzname:</strong> Sollte aussagekräftig und eindeutig sein</li>
                                    <li><strong>Bewertungsskala:</strong> Bestimmt die verfügbaren Bewertungsoptionen</li>
                                    <li><strong>Status:</strong> Nur aktive Kompetenzen können neuen MABs zugewiesen werden</li>
                                </ul>
                            </div>

                            <div class="card">
                                <div class="card-header">
                                    <h6>Verfügbare Bewertungsskalen</h6>
                                </div>
                                <div class="card-body">
                                    <g:if test="${ratingScales}">
                                        <g:each in="${ratingScales}" var="scale">
                                            <div class="mb-2">
                                                <strong>${scale.ratingScaleName}</strong>
                                                <div class="text-muted small">
                                                    Bewertungen:
                                                    <g:each in="${mab.Rating.findAllByRatingScale(scale, [sort: 'sortOrder'])}" var="rating" status="i">
                                                        ${rating.ratingName}${i < mab.Rating.countByRatingScale(scale) - 1 ? ', ' : ''}
                                                    </g:each>
                                                </div>
                                            </div>
                                        </g:each>
                                    </g:if>
                                    <g:else>
                                        <p class="text-muted">Keine Bewertungsskalen verfügbar.</p>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <g:submitButton name="create" class="btn btn-success" value="Kompetenz erstellen" />
                        <g:link class="btn btn-secondary" action="index">Abbrechen</g:link>
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