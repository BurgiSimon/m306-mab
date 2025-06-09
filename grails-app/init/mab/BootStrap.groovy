import mab.*

class BootStrap {

    def init = { servletContext ->

        if (MABStatus.count() == 0) {
            log.info "Creating initial data..."

            // MAB Status erstellen
            def statusBewertung = new MABStatus(mabStatusName: "Bewertung Vorgesetzter").save(flush: true, failOnError: true)
            def statusFreigabe = new MABStatus(mabStatusName: "Freigabe Supervisor").save(flush: true, failOnError: true)
            def statusGespraech = new MABStatus(mabStatusName: "MA-Gespräch").save(flush: true, failOnError: true)
            def statusSignieren = new MABStatus(mabStatusName: "MAB Signieren").save(flush: true, failOnError: true)
            def statusAbgeschlossen = new MABStatus(mabStatusName: "MAB abgeschlossen").save(flush: true, failOnError: true)

            // Rollen erstellen
            def roleVorgesetzter = new Role(roleName: "Vorgesetzter").save(flush: true, failOnError: true)
            def roleMitarbeiter = new Role(roleName: "Mitarbeiter").save(flush: true, failOnError: true)
            def roleSupervisor = new Role(roleName: "Supervisor").save(flush: true, failOnError: true)
            def roleHR = new Role(roleName: "HR").save(flush: true, failOnError: true)

            // Rating Scale erstellen
            def ratingScale5 = new RatingScale(ratingScaleName: "5-Punkte-Skala", sortOrder: 1).save(flush: true, failOnError: true)
            def ratingScale3 = new RatingScale(ratingScaleName: "3-Punkte-Skala", sortOrder: 2).save(flush: true, failOnError: true)

            // Ratings für 5-Punkte-Skala
            def rating1 = new Rating(ratingScale: ratingScale5, ratingName: "Ungenügend", points: 1, sortOrder: 1).save(flush: true, failOnError: true)
            def rating2 = new Rating(ratingScale: ratingScale5, ratingName: "Mangelhaft", points: 2, sortOrder: 2).save(flush: true, failOnError: true)
            def rating3 = new Rating(ratingScale: ratingScale5, ratingName: "Befriedigend", points: 3, sortOrder: 3).save(flush: true, failOnError: true)
            def rating4 = new Rating(ratingScale: ratingScale5, ratingName: "Gut", points: 4, sortOrder: 4).save(flush: true, failOnError: true)
            def rating5 = new Rating(ratingScale: ratingScale5, ratingName: "Sehr gut", points: 5, sortOrder: 5).save(flush: true, failOnError: true)

            // Ratings für 3-Punkte-Skala
            def rating3_1 = new Rating(ratingScale: ratingScale3, ratingName: "Unter Erwartung", points: 1, sortOrder: 1).save(flush: true, failOnError: true)
            def rating3_2 = new Rating(ratingScale: ratingScale3, ratingName: "Erfüllt Erwartung", points: 2, sortOrder: 2).save(flush: true, failOnError: true)
            def rating3_3 = new Rating(ratingScale: ratingScale3, ratingName: "Übertrifft Erwartung", points: 3, sortOrder: 3).save(flush: true, failOnError: true)

            // Kompetenzen erstellen
            def kompFachlich = new Competence(ratingScale: ratingScale5, competenceName: "Fachliche Kompetenz", competenceActive: true).save(flush: true, failOnError: true)
            def kompSozial = new Competence(ratingScale: ratingScale5, competenceName: "Soziale Kompetenz", competenceActive: true).save(flush: true, failOnError: true)
            def kompKommunikation = new Competence(ratingScale: ratingScale5, competenceName: "Kommunikation", competenceActive: true).save(flush: true, failOnError: true)
            def kompFuehrung = new Competence(ratingScale: ratingScale3, competenceName: "Führungskompetenz", competenceActive: true).save(flush: true, failOnError: true)
            def kompTeamwork = new Competence(ratingScale: ratingScale5, competenceName: "Teamarbeit", competenceActive: true).save(flush: true, failOnError: true)

            log.info "Initial data created successfully"
        }
    }

    def destroy = {
    }
}