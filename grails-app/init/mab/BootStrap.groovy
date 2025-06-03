import mab.*

class BootStrap {

    def init = { servletContext ->

        if (MABStatus.count() == 0) {
            log.info "Creating initial data..."

            // MAB Status erstellen
            def statusBewertung = new MABStatus(mabStatusName: "Bewertung Vorgesetzter")
            if (!statusBewertung.save(flush: true)) {
                log.error "Failed to save statusBewertung: ${statusBewertung.errors}"
            }

            def statusFreigabe = new MABStatus(mabStatusName: "Freigabe Supervisor")
            if (!statusFreigabe.save(flush: true)) {
                log.error "Failed to save statusFreigabe: ${statusFreigabe.errors}"
            }

            def statusGespraech = new MABStatus(mabStatusName: "MA-Gespräch")
            if (!statusGespraech.save(flush: true)) {
                log.error "Failed to save statusGespraech: ${statusGespraech.errors}"
            }

            def statusSignieren = new MABStatus(mabStatusName: "MAB Signieren")
            if (!statusSignieren.save(flush: true)) {
                log.error "Failed to save statusSignieren: ${statusSignieren.errors}"
            }

            def statusAbgeschlossen = new MABStatus(mabStatusName: "MAB abgeschlossen")
            if (!statusAbgeschlossen.save(flush: true)) {
                log.error "Failed to save statusAbgeschlossen: ${statusAbgeschlossen.errors}"
            }

            // Rollen erstellen
            def roleVorgesetzter = new Role(roleName: "Vorgesetzter")
            if (!roleVorgesetzter.save(flush: true)) {
                log.error "Failed to save roleVorgesetzter: ${roleVorgesetzter.errors}"
            }

            def roleMitarbeiter = new Role(roleName: "Mitarbeiter")
            if (!roleMitarbeiter.save(flush: true)) {
                log.error "Failed to save roleMitarbeiter: ${roleMitarbeiter.errors}"
            }

            // Rating Scale erstellen
            def ratingScale5 = new RatingScale(ratingScaleName: "5-Punkte-Skala", sortOrder: 1)
            if (!ratingScale5.save(flush: true)) {
                log.error "Failed to save ratingScale5: ${ratingScale5.errors}"
            }

            // Ratings für 5-Punkte-Skala
            def rating1 = new Rating(ratingScale: ratingScale5, ratingName: "Ungenügend", points: 1, sortOrder: 1)
            if (!rating1.save(flush: true)) {
                log.error "Failed to save rating1: ${rating1.errors}"
            }

            def rating2 = new Rating(ratingScale: ratingScale5, ratingName: "Mangelhaft", points: 2, sortOrder: 2)
            if (!rating2.save(flush: true)) {
                log.error "Failed to save rating2: ${rating2.errors}"
            }

            def rating3 = new Rating(ratingScale: ratingScale5, ratingName: "Befriedigend", points: 3, sortOrder: 3)
            if (!rating3.save(flush: true)) {
                log.error "Failed to save rating3: ${rating3.errors}"
            }

            def rating4 = new Rating(ratingScale: ratingScale5, ratingName: "Gut", points: 4, sortOrder: 4)
            if (!rating4.save(flush: true)) {
                log.error "Failed to save rating4: ${rating4.errors}"
            }

            def rating5 = new Rating(ratingScale: ratingScale5, ratingName: "Sehr gut", points: 5, sortOrder: 5)
            if (!rating5.save(flush: true)) {
                log.error "Failed to save rating5: ${rating5.errors}"
            }

            // Kompetenzen erstellen
            def kompFachlich = new Competence(ratingScale: ratingScale5, competenceName: "Fachliche Kompetenz", competenceActive: true)
            if (!kompFachlich.save(flush: true)) {
                log.error "Failed to save kompFachlich: ${kompFachlich.errors}"
            }

            def kompSozial = new Competence(ratingScale: ratingScale5, competenceName: "Soziale Kompetenz", competenceActive: true)
            if (!kompSozial.save(flush: true)) {
                log.error "Failed to save kompSozial: ${kompSozial.errors}"
            }

            def kompKommunikation = new Competence(ratingScale: ratingScale5, competenceName: "Kommunikation", competenceActive: true)
            if (!kompKommunikation.save(flush: true)) {
                log.error "Failed to save kompKommunikation: ${kompKommunikation.errors}"
            }

            log.info "Initial data created successfully"
        }
    }

    def destroy = {
    }
}