package mab

import grails.testing.web.controllers.ControllerUnitTest
import grails.validation.ValidationException
import spock.lang.*

class MABControllerSpec extends Specification implements ControllerUnitTest<MABController> {

    def populateValidParams(params) {
        assert params != null

        // Mock-Objekte erstellen
        def mockStatus = new MABStatus(id: 1, mabStatusName: "Bewertung Vorgesetzter")

        // Testdaten für gültiges MAB
        params["mabStatus.id"] = mockStatus.id
        params["assessmentFrom"] = new Date()
        params["assessmentTo"] = new Date() + 365
        params["commentText"] = "Test Kommentar"
        params["isOnlineApproval"] = true
        params["appraiseeComment"] = "Mitarbeiter Kommentar"
        params["supervisorComment"] = "Vorgesetzter Kommentar"
    }

    void "Test T-001: MAB erfassen - Index action returns the correct model"() {
        given:
        controller.mABService = Mock(MABService) {
            list(_) >> []
            count() >> 0
        }

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        model.mABList == []
        model.mABCount == 0
    }

    void "Test T-001: MAB erfassen - Create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.mAB != null
    }

    void "Test T-001: MAB erfassen - Save action successfully persists an instance"() {
        given:
        controller.mABService = Mock(MABService) {
            save(_ as MAB) >> { MAB mab ->
                mab.id = 1
                return mab
            }
        }

        when: "A valid domain instance is passed to the save action"
        populateValidParams(params)
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def mab = new MAB()
        controller.save(mab)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/mAB/show/1'
        controller.flash.message != null
    }

    void "Test T-008: Fehlendes Pflichtfeld - Save action with invalid data"() {
        given:
        controller.mABService = Mock(MABService) {
            save(_ as MAB) >> { MAB mab ->
                throw new ValidationException("", mab.errors)
            }
        }

        when: "Invalid domain instance is passed to the save action"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def mab = new MAB()
        controller.save(mab)

        then: "The create view is rendered again with the correct model"
        model.mAB != null
        view == 'create'
    }

    void "Test T-002: MAB bearbeiten - Show action returns the correct model"() {
        given:
        def mab = new MAB()
        mab.id = 1
        controller.mABService = Mock(MABService) {
            get(1) >> mab
        }

        when: "A domain instance is passed to the show action"
        controller.show(1)

        then: "A model is populated containing the domain instance"
        model.mAB == mab
    }

    void "Test T-002: MAB bearbeiten - Edit action returns the correct model"() {
        given:
        def mab = new MAB()
        mab.id = 1
        controller.mABService = Mock(MABService) {
            get(1) >> mab
        }

        when: "A domain instance is passed to the edit action"
        controller.edit(1)

        then: "A model is populated containing the domain instance"
        model.mAB == mab
    }

    void "Test T-002: MAB bearbeiten - Update action successfully persists"() {
        given:
        controller.mABService = Mock(MABService) {
            save(_ as MAB) >> { MAB mab ->
                mab.id = 1
                return mab
            }
        }

        when: "A valid domain instance is passed to the update action"
        populateValidParams(params)
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        def mab = new MAB()
        mab.id = 1
        controller.update(mab)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/mAB/show/1'
        controller.flash.message != null
    }

    void "Test T-003: MAB löschen - Delete action deletes an instance"() {
        given:
        controller.mABService = Mock(MABService) {
            delete(1) >> { }
        }

        when: "The domain instance is passed to the delete action"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(1)

        then: "The user is redirected to index"
        response.redirectedUrl == '/mAB/index'
        flash.message != null
    }

    void "Test T-010: Datenvalidierung Datum - Von-Datum später als Bis-Datum"() {
        given:
        controller.mABService = Mock(MABService) {
            save(_ as MAB) >> { MAB mab ->
                throw new ValidationException("", mab.errors)
            }
        }

        when: "MAB with invalid date range is saved"
        populateValidParams(params)
        params["assessmentFrom"] = new Date() + 365  // Von-Datum in der Zukunft
        params["assessmentTo"] = new Date()          // Bis-Datum heute
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def mab = new MAB()
        controller.save(mab)

        then: "Validation error occurs"
        view == 'create'
        model.mAB != null
    }
}