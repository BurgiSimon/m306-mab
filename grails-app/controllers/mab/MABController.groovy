package mab

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class MABController {

    MABService mABService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond mABService.list(params), model:[mABCount: mABService.count()]
    }

    def show(Long id) {
        respond mABService.get(id)
    }

    def create() {
        def mabStatuses = MABStatus.list()
        respond new MAB(params), model: [mabStatuses: mabStatuses]
    }

    def save(MAB mAB) {
        if (mAB == null) {
            notFound()
            return
        }

        try {
            mABService.save(mAB)
        } catch (ValidationException e) {
            def mabStatuses = MABStatus.list()
            respond mAB.errors, view:'create', model: [mabStatuses: mabStatuses]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'mAB.label', default: 'MAB'), mAB.id])
                redirect mAB
            }
            '*' { respond mAB, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def mab = mABService.get(id)
        def mabStatuses = MABStatus.list()
        respond mab, model: [mabStatuses: mabStatuses]
    }

    def update(MAB mAB) {
        if (mAB == null) {
            notFound()
            return
        }

        try {
            mABService.save(mAB)
        } catch (ValidationException e) {
            def mabStatuses = MABStatus.list()
            respond mAB.errors, view:'edit', model: [mabStatuses: mabStatuses]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'mAB.label', default: 'MAB'), mAB.id])
                redirect mAB
            }
            '*' { respond mAB, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        mABService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'mAB.label', default: 'MAB'), id])
                redirect action:"index", method:"GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'mAB.label', default: 'MAB'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def addCompetence(Long id) {
        def mab = mABService.get(id)
        if (!mab) {
            notFound()
            return
        }

        def competences = Competence.findAllByCompetenceActive(true)
        respond mab, model: [competences: competences]
    }

    def saveCompetence() {
        def mab = MAB.get(params.mabId)
        def competence = Competence.get(params.competenceId)

        if (!mab || !competence) {
            flash.error = "MAB oder Kompetenz nicht gefunden"
            redirect action: "index"
            return
        }

        // Prüfen ob Kompetenz bereits zugewiesen ist
        def existing = MABCompetence.findByMabAndCompetence(mab, competence)
        if (existing) {
            flash.error = "Kompetenz ist bereits zugewiesen"
        } else {
            def mabCompetence = new MABCompetence(
                    mab: mab,
                    competence: competence,
                    descriptionText: params.descriptionText,
                    assessmentText: params.assessmentText
            )

            if (params.ratingId) {
                mabCompetence.rating = Rating.get(params.ratingId)
            }

            mabCompetence.save(flush: true)
            flash.message = "Kompetenz erfolgreich zugewiesen"
        }

        redirect action: "show", id: mab.id
    }
}