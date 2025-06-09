<%--
  Created by IntelliJ IDEA.
  User: simon
  Date: 6/3/25
  Time: 10:51 AM
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Kompetenz hinzufügen</title>
</head>
<body>
<div class="row">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><g:link action="index">MAB Verwaltung</g:link></li>
                <li class="breadcrumb-item"><g:link action="show" id="${mAB?.id}">MAB ${mAB?.id}</g:link></li>
                <li class="breadcrumb-item active">Kompetenz hinzufügen</li>
            </ol>
        </nav>

        <h1><i class="fas fa-star"></i> Kompetenz zu MAB hinzufügen</h1>

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
                <h5>Kompetenz auswählen und bewerten</h5>
            </div>
            <div class="card-body">
                <g:form action="saveCompetence" class="needs-validation" novalidate="true">
                    <g:hiddenField name="mabId" value="${mAB?.id}" />

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="competenceId" class="form-label">Kompetenz <span class="text-danger">*</span></label>
                                <select name="competenceId" class="form-select" required>
                                    <option value="">-- Kompetenz auswählen --</option>
                                    <g:each in="${competences}" var="comp">
                                        <option value="${comp.id}">${comp.competenceName} (${comp.ratingScale})</option>
                                    </g:each>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="ratingId" class="form-label">Bewertung</label>
                                <select name="ratingId" class="form-select" id="ratingSelect">
                                    <option value="">-- Zuerst Kompetenz auswählen --</option>
                                </select>
                                <div class="form-text">Wählen Sie zuerst eine Kompetenz aus, um die verfügbaren Bewertungen zu sehen.</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descriptionText" class="form-label">Beschreibung</label>
                                <g:textArea name="descriptionText"
                                            rows="4"
                                            class="form-control"
                                            maxlength="1500"
                                            placeholder="Beschreibung der Kompetenz und ihrer Bedeutung..." />
                                <div class="form-text">Maximal 1500 Zeichen</div>
                            </div>

                            <div class="mb-3">
                                <label for="assessmentText" class="form-label">Bewertungskommentar</label>
                                <g:textArea name="assessmentText"
                                            rows="4"
                                            class="form-control"
                                            maxlength="500"
                                            placeholder="Kommentar zur Bewertung..." />
                                <div class="form-text">Maximal 500 Zeichen</div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <g:submitButton name="save" class="btn btn-success" value="Kompetenz hinzufügen" />
                        <g:link class="btn btn-secondary" action="show" id="${mAB?.id}">Abbrechen</g:link>
                    </div>
                </g:form>
            </div>
        </div>

    <!-- Bereits zugewiesene Kompetenzen -->
        <g:if test="${mAB?.mabCompetences}">
            <div class="card mt-4">
                <div class="card-header">
                    <h5>Bereits zugewiesene Kompetenzen</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>Kompetenz</th>
                                <th>Bewertung</th>
                                <th>Beschreibung</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mAB.mabCompetences}" var="comp">
                                <tr>
                                    <td>${comp.competence.competenceName}</td>
                                    <td>
                                        <g:if test="${comp.rating}">
                                            <span class="badge bg-primary">${comp.rating.ratingName}</span>
                                        </g:if>
                                        <g:else>
                                            <span class="badge bg-secondary">Nicht bewertet</span>
                                        </g:else>
                                    </td>
                                    <td>${comp.descriptionText ?: '-'}</td>
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
    // Rating-Optionen basierend auf gewählter Kompetenz laden
    document.addEventListener('DOMContentLoaded', function() {
        const competenceSelect = document.querySelector('select[name="competenceId"]');
        const ratingSelect = document.getElementById('ratingSelect');

        // Mapping von Kompetenz zu verfügbaren Ratings (in echtem System via AJAX)
        const competenceRatings = {
            <g:each in="${competences}" var="comp">
            '${comp.id}': [
                <g:each in="${comp.ratingScale.ratings?.sort { it.sortOrder }}" var="rating">
                {id: '${rating.id}', name: '${rating.ratingName}', points: '${rating.points ?: "N/A"}'},
                </g:each>
            ],
            </g:each>
        };

        competenceSelect.addEventListener('change', function() {
            const competenceId = this.value;
            ratingSelect.innerHTML = '<option value="">-- Bewertung auswählen --</option>';

            if (competenceId && competenceRatings[competenceId]) {
                competenceRatings[competenceId].forEach(function(rating) {
                    const option = document.createElement('option');
                    option.value = rating.id;
                    option.textContent = rating.name + ' (' + rating.points + ' Punkte)';
                    ratingSelect.appendChild(option);
                });
                ratingSelect.disabled = false;
            } else {
                ratingSelect.disabled = true;
            }
        });
    });

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