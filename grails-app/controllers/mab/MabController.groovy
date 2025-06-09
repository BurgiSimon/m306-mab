package mab

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class MabController {

    MabService mabService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        // Enhanced search functionality
        def criteria = MAB.createCriteria()
        def mabList = criteria.list(params) {
            if (params.search) {
                or {
                    ilike("commentText", "%${params.search}%")
                    ilike("appraiseeComment", "%${params.search}%")
                    ilike("supervisorComment", "%${params.search}%")
                    mabStatus {
                        ilike("mabStatusName", "%${params.search}%")
                    }
                }
            }
            if (params.status) {
                mabStatus {
                    eq("id", params.status.toLong())
                }
            }
            order("createDate", "desc")
        }

        def mabStatuses = MABStatus.list()
        respond mabList, model:[
                mabCount: mabService.count(),
                mabStatuses: mabStatuses,
                searchParams: params
        ]
    }

    def show(Long id) {
        respond mabService.get(id)
    }

    def create() {
        def mabStatuses = MABStatus.list()
        respond new MAB(params), model: [mabStatuses: mabStatuses]
    }

    def save(MAB mab) {
        if (mab == null) {
            notFound()
            return
        }

        try {
            mabService.save(mab)
        } catch (ValidationException e) {
            def mabStatuses = MABStatus.list()
            respond mab.errors, view:'create', model: [mabStatuses: mabStatuses]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'mab.label', default: 'MAB'), mab.id])
                redirect mab
            }
            '*' { respond mab, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def mab = mabService.get(id)
        def mabStatuses = MABStatus.list()
        respond mab, model: [mabStatuses: mabStatuses]
    }

    def update(MAB mab) {
        if (mab == null) {
            notFound()
            return
        }

        try {
            mabService.save(mab)
        } catch (ValidationException e) {
            def mabStatuses = MABStatus.list()
            respond mab.errors, view:'edit', model: [mabStatuses: mabStatuses]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'mab.label', default: 'MAB'), mab.id])
                redirect mab
            }
            '*' { respond mab, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        mabService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'mab.label', default: 'MAB'), id])
                redirect action:"index", method:"GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    def addCompetence(Long id) {
        def mab = mabService.get(id)
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

        // Check if competence is already assigned
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

    // New: Role management
    def addRole(Long id) {
        def mab = mabService.get(id)
        if (!mab) {
            notFound()
            return
        }

        def roles = Role.list()
        respond mab, model: [roles: roles]
    }

    def saveRole() {
        def mab = MAB.get(params.mabId)
        def role = Role.get(params.roleId)

        if (!mab || !role) {
            flash.error = "MAB oder Rolle nicht gefunden"
            redirect action: "index"
            return
        }

        def mabRole = new MABRole(
                mab: mab,
                role: role,
                empNum: params.empNum ? Integer.parseInt(params.empNum) : null,
                login: params.login,
                lastName: params.lastName,
                firstName: params.firstName,
                mail: params.mail,
                hasApproved: false
        )

        if (mabRole.save(flush: true)) {
            flash.message = "Person erfolgreich zugewiesen"
        } else {
            flash.error = "Fehler beim Speichern der Person"
        }

        redirect action: "show", id: mab.id
    }

    // New: Workflow status update
    def updateStatus() {
        def mab = MAB.get(params.mabId)
        def newStatus = MABStatus.get(params.statusId)

        if (!mab || !newStatus) {
            flash.error = "MAB oder Status nicht gefunden"
            redirect action: "index"
            return
        }

        mab.mabStatus = newStatus
        if (mab.save(flush: true)) {
            flash.message = "Status erfolgreich geändert zu: ${newStatus.mabStatusName}"
        } else {
            flash.error = "Fehler beim Ändern des Status"
        }

        redirect action: "show", id: mab.id
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'mab.label', default: 'MAB'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}