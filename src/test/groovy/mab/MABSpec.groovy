package mab

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class MABSpec extends Specification implements DomainUnitTest<MAB> {

    def setup() {
        // Mock dependencies
        mockDomains(MABStatus, RatingScale, Competence, Rating, MABRole, MABCompetence, Role)
    }

    void "Test T-001: MAB erfassen - Valid MAB can be saved"() {
        given: "A valid MAB instance"
        def status = new MABStatus(mabStatusName: "Bewertung Vorgesetzter").save()
        def mab = new MAB(
                mabStatus: status,
                assessmentFrom: new Date(),
                assessmentTo: new Date() + 365,
                commentText: "Test Kommentar",
                isOnlineApproval: true
        )

        when: "The MAB is validated"
        def result = mab.validate()

        then: "Validation passes"
        result == true
        mab.errors.errorCount == 0
    }

    void "Test T-008: Fehlendes Pflichtfeld - MAB without required fields fails validation"() {
        given: "An invalid MAB instance"
        def mab = new MAB()

        when: "The MAB is validated"
        def result = mab.validate()

        then: "Validation fails"
        result == false
        mab.errors.errorCount > 0
        mab.errors.getFieldError('mabStatus') != null
        mab.errors.getFieldError('assessmentFrom') != null
        mab.errors.getFieldError('assessmentTo') != null
    }

    void "Test T-010: Datenvalidierung Datum - Assessment dates validation"() {
        given: "A MAB with invalid date range"
        def status = new MABStatus(mabStatusName: "Bewertung Vorgesetzter").save()
        def today = new Date()
        def yesterday = today - 1

        def mab = new MAB(
                mabStatus: status,
                assessmentFrom: today,      // Später
                assessmentTo: yesterday,    // Früher
                isOnlineApproval: false
        )

        when: "The MAB is validated"
        def result = mab.validate()

        then: "Validation fails for date range"
        result == false
        mab.errors.getFieldError('assessmentTo') != null
    }

    void "Test: MAB toString method works correctly"() {
        given: "A MAB with dates"
        def status = new MABStatus(mabStatusName: "Test Status").save()
        def from = Date.parse('dd.MM.yyyy', '01.01.2024')
        def to = Date.parse('dd.MM.yyyy', '31.12.2024')

        def mab = new MAB(
                mabStatus: status,
                assessmentFrom: from,
                assessmentTo: to,
                isOnlineApproval: true
        )
        mab.id = 123

        when: "toString is called"
        def result = mab.toString()

        then: "String representation is correct"
        result.contains("MAB 123")
        result.contains("01.01.2024")
        result.contains("31.12.2024")
    }

    void "Test: Comment text length validation"() {
        given: "A MAB with too long comment"
        def status = new MABStatus(mabStatusName: "Test Status").save()
        def longComment = "x" * 1001  // Überschreitet Maximum von 1000

        def mab = new MAB(
                mabStatus: status,
                assessmentFrom: new Date(),
                assessmentTo: new Date() + 365,
                commentText: longComment,
                isOnlineApproval: false
        )

        when: "The MAB is validated"
        def result = mab.validate()

        then: "Validation fails for comment length"
        result == false
        mab.errors.getFieldError('commentText') != null
    }

    void "Test: MAB with valid relationships"() {
        given: "MAB with roles and competences"
        def status = new MABStatus(mabStatusName: "Test Status").save()
        def role = new Role(roleName: "Test Role").save()
        def ratingScale = new RatingScale(ratingScaleName: "Test Scale").save()
        def competence = new Competence(
                competenceName: "Test Competence",
                ratingScale: ratingScale,
                competenceActive: true
        ).save()
        def rating = new Rating(
                ratingScale: ratingScale,
                ratingName: "Good",
                points: 4
        ).save()

        def mab = new MAB(
                mabStatus: status,
                assessmentFrom: new Date(),
                assessmentTo: new Date() + 365,
                isOnlineApproval: true
        ).save()

        def mabRole = new MABRole(
                mab: mab,
                role: role,
                firstName: "John",
                lastName: "Doe",
                mail: "john.doe@test.com",
                hasApproved: false
        ).save()

        def mabCompetence = new MABCompetence(
                mab: mab,
                competence: competence,
                rating: rating,
                descriptionText: "Test description"
        ).save()

        when: "Relationships are accessed"
        mab.refresh()

        then: "Relationships work correctly"
        mab.mabRoles.size() == 1
        mab.mabCompetences.size() == 1
        mab.mabRoles[0].firstName == "John"
        mab.mabCompetences[0].competence.competenceName == "Test Competence"
    }
}