package mab

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CompetenceController {

    CompetenceService competenceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond competenceService.list(params), model:[competenceCount: competenceService.count()]
    }

    def show(Long id) {
        respond competenceService.get(id)
    }

    def create() {
        respond new Competence(params), model: [ratingScales: RatingScale.list()]
    }

    def save(Competence competence) {
        if (competence == null) {
            notFound()
            return
        }

        try {
            competenceService.save(competence)
        } catch (ValidationException e) {
            respond competence.errors, view:'create', model: [ratingScales: RatingScale.list()]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'competence.label', default: 'Competence'), competence.id])
                redirect competence
            }
            '*' { respond competence, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond competenceService.get(id), model: [ratingScales: RatingScale.list()]
    }

    def update(Competence competence) {
        if (competence == null) {
            notFound()
            return
        }

        try {
            competenceService.save(competence)
        } catch (ValidationException e) {
            respond competence.errors, view:'edit', model: [ratingScales: RatingScale.list()]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'competence.label', default: 'Competence'), competence.id])
                redirect competence
            }
            '*' { respond competence, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        competenceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'competence.label', default: 'Competence'), id])
                redirect action:"index", method:"GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'competence.label', default: 'Competence'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}