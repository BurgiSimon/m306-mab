<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'mAB.label', default: 'MAB')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">MAB Verwaltung</g:link></li>
                <li class="breadcrumb-item active">Neue MAB erstellen</li>
            </ol>
        </nav>

        <h1><i class="fas fa-plus"></i> Neue Mitarbeiterbeurteilung erstellen</h1>

        <g:hasErrors bean="${mAB}">
            <div class="alert alert-danger">
                <g:renderErrors bean="${mAB}" as="list" />
            </div>
        </g:hasErrors>

        <div class="card">
            <div class="card-body">
                <g:form action="save" class="needs-validation" novalidate="true">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="mabStatus" class="form-label">Status <span class="text-danger">*</span></label>
                                <g:select name="mabStatus.id"
                                          from="${mabStatuses}"
                                          optionKey="id"
                                          optionValue="mabStatusName"
                                          value="${mAB?.mabStatus?.id}"
                                          class="form-select"
                                          required="true" />
                            </div>

                            <div class="mb-3">
                                <label for="assessmentFrom" class="form-label">Beurteilung von <span class="text-danger">*</span></label>
                                <g:datePicker name="assessmentFrom"
                                              value="${mAB?.assessmentFrom}"
                                              precision="day"
                                              class="form-control"
                                              required="true" />
                            </div>

                            <div class="mb-3">
                                <label for="assessmentTo" class="form-label">Beurteilung bis <span class="text-danger">*</span></label>
                                <g:datePicker name="assessmentTo"
                                              value="${mAB?.assessmentTo}"
                                              precision="day"
                                              class="form-control"
                                              required="true" />
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <g:checkBox name="isOnlineApproval"
                                                value="${mAB?.isOnlineApproval}"
                                                class="form-check-input" />
                                    <label class="form-check-label" for="isOnlineApproval">
                                        Online Freigabe
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="commentText" class="form-label">Allgemeiner Kommentar</label>
                                <g:textArea name="commentText"
                                            value="${mAB?.commentText}"
                                            rows="3"
                                            class="form-control"
                                            maxlength="1000" />
                                <div class="form-text">Maximal 1000 Zeichen</div>
                            </div>

                            <div class="mb-3">
                                <label for="appraiseeComment" class="form-label">Mitarbeiter-Kommentar</label>
                                <g:textArea name="appraiseeComment"
                                            value="${mAB?.appraiseeComment}"
                                            rows="3"
                                            class="form-control"
                                            maxlength="1000" />
                            </div>

                            <div class="mb-3">
                                <label for="supervisorComment" class="form-label">Vorgesetzter-Kommentar</label>
                                <g:textArea name="supervisorComment"
                                            value="${mAB?.supervisorComment}"
                                            rows="3"
                                            class="form-control"
                                            maxlength="1000" />
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <g:submitButton name="create" class="btn btn-success" value="MAB erstellen" />
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