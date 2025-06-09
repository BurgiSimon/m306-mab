import mab.*

class BootStrap {

    def init = { servletContext ->

        println "=== BOOTSTRAP STARTING ==="
        log.info "BootStrap init started..."

        try {
            // Prüfen ob bereits Daten vorhanden sind
            if (MABStatus.count() == 0) {
                println "Creating demo data..."
                log.info "Creating demo data..."

                // 1. MAB Status erstellen
                println "Creating MAB Status..."
                def statusBewertung = new MABStatus(mabStatusName: "Bewertung Vorgesetzter")
                statusBewertung.save(flush: true, failOnError: true)

                def statusFreigabe = new MABStatus(mabStatusName: "Freigabe Supervisor")
                statusFreigabe.save(flush: true, failOnError: true)

                def statusGespraech = new MABStatus(mabStatusName: "MA-Gespräch")
                statusGespraech.save(flush: true, failOnError: true)

                def statusSignieren = new MABStatus(mabStatusName: "MAB Signieren")
                statusSignieren.save(flush: true, failOnError: true)

                def statusAbgeschlossen = new MABStatus(mabStatusName: "MAB abgeschlossen")
                statusAbgeschlossen.save(flush: true, failOnError: true)

                println "Created ${MABStatus.count()} MAB Status entries"

                // 2. Rollen erstellen
                println "Creating Roles..."
                def roleVorgesetzter = new Role(roleName: "Vorgesetzter")
                roleVorgesetzter.save(flush: true, failOnError: true)

                def roleMitarbeiter = new Role(roleName: "Mitarbeiter")
                roleMitarbeiter.save(flush: true, failOnError: true)

                def roleSupervisor = new Role(roleName: "Supervisor")
                roleSupervisor.save(flush: true, failOnError: true)

                def roleHR = new Role(roleName: "HR")
                roleHR.save(flush: true, failOnError: true)

                println "Created ${Role.count()} Roles"

                // 3. Rating Scale erstellen
                println "Creating Rating Scales..."
                def ratingScale5 = new RatingScale(ratingScaleName: "5-Punkte-Skala", sortOrder: 1)
                ratingScale5.save(flush: true, failOnError: true)

                def ratingScale3 = new RatingScale(ratingScaleName: "3-Punkte-Skala", sortOrder: 2)
                ratingScale3.save(flush: true, failOnError: true)

                println "Created ${RatingScale.count()} Rating Scales"

                // 4. Ratings für 5-Punkte-Skala
                println "Creating Ratings..."
                def rating5_1 = new Rating(ratingScale: ratingScale5, ratingName: "Ungenügend", points: 1, sortOrder: 1)
                rating5_1.save(flush: true, failOnError: true)

                def rating5_2 = new Rating(ratingScale: ratingScale5, ratingName: "Mangelhaft", points: 2, sortOrder: 2)
                rating5_2.save(flush: true, failOnError: true)

                def rating5_3 = new Rating(ratingScale: ratingScale5, ratingName: "Befriedigend", points: 3, sortOrder: 3)
                rating5_3.save(flush: true, failOnError: true)

                def rating5_4 = new Rating(ratingScale: ratingScale5, ratingName: "Gut", points: 4, sortOrder: 4)
                rating5_4.save(flush: true, failOnError: true)

                def rating5_5 = new Rating(ratingScale: ratingScale5, ratingName: "Sehr gut", points: 5, sortOrder: 5)
                rating5_5.save(flush: true, failOnError: true)

                // 5. Ratings für 3-Punkte-Skala
                def rating3_1 = new Rating(ratingScale: ratingScale3, ratingName: "Unter Erwartung", points: 1, sortOrder: 1)
                rating3_1.save(flush: true, failOnError: true)

                def rating3_2 = new Rating(ratingScale: ratingScale3, ratingName: "Erfüllt Erwartung", points: 2, sortOrder: 2)
                rating3_2.save(flush: true, failOnError: true)

                def rating3_3 = new Rating(ratingScale: ratingScale3, ratingName: "Übertrifft Erwartung", points: 3, sortOrder: 3)
                rating3_3.save(flush: true, failOnError: true)

                println "Created ${Rating.count()} Ratings"

                // 6. Kompetenzen erstellen
                println "Creating Competencies..."
                def kompFachlich = new Competence(ratingScale: ratingScale5, competenceName: "Fachliche Kompetenz", competenceActive: true)
                kompFachlich.save(flush: true, failOnError: true)

                def kompSozial = new Competence(ratingScale: ratingScale5, competenceName: "Soziale Kompetenz", competenceActive: true)
                kompSozial.save(flush: true, failOnError: true)

                def kompKommunikation = new Competence(ratingScale: ratingScale5, competenceName: "Kommunikation", competenceActive: true)
                kompKommunikation.save(flush: true, failOnError: true)

                def kompFuehrung = new Competence(ratingScale: ratingScale3, competenceName: "Führungskompetenz", competenceActive: true)
                kompFuehrung.save(flush: true, failOnError: true)

                def kompTeamwork = new Competence(ratingScale: ratingScale5, competenceName: "Teamarbeit", competenceActive: true)
                kompTeamwork.save(flush: true, failOnError: true)

                println "Created ${Competence.count()} Competencies"

                // 7. Demo MABs erstellen
                println "Creating MAB entries..."
                def mab1 = new MAB(
                        mabStatus: statusBewertung,
                        assessmentFrom: Date.parse('dd.MM.yyyy', '01.01.2024'),
                        assessmentTo: Date.parse('dd.MM.yyyy', '31.12.2024'),
                        commentText: "Jährliche Leistungsbeurteilung für Software Entwickler. Fokus auf technische Fähigkeiten und Projektmitarbeit.",
                        isOnlineApproval: true,
                        createDate: new Date() - 30,
                        appraiseeComment: "Ich habe dieses Jahr viel über neue Technologien gelernt.",
                        supervisorComment: "Sehr zuverlässiger Mitarbeiter mit ausgezeichneten technischen Fähigkeiten."
                )
                mab1.save(flush: true, failOnError: true)

                def mab2 = new MAB(
                        mabStatus: statusFreigabe,
                        assessmentFrom: Date.parse('dd.MM.yyyy', '01.07.2023'),
                        assessmentTo: Date.parse('dd.MM.yyyy', '30.06.2024'),
                        commentText: "Beurteilung der Projektmanagement-Kompetenzen und Führungsleistung.",
                        isOnlineApproval: true,
                        createDate: new Date() - 60,
                        appraiseeComment: "Habe mehrere Projekte erfolgreich geleitet.",
                        supervisorComment: "Hervorragende Führungsqualitäten.",
                        hrComment: "Empfehlung für Beförderung."
                )
                mab2.save(flush: true, failOnError: true)

                def mab3 = new MAB(
                        mabStatus: statusAbgeschlossen,
                        assessmentFrom: Date.parse('dd.MM.yyyy', '01.01.2023'),
                        assessmentTo: Date.parse('dd.MM.yyyy', '31.12.2023'),
                        commentText: "Vollständige Jahresbeurteilung mit Fokus auf Führungskompetenzen.",
                        isOnlineApproval: true,
                        createDate: new Date() - 120,
                        appraiseeComment: "War ein erfolgreiches Jahr.",
                        supervisorComment: "Ausgezeichnete Leistung in allen Bereichen.",
                        hrComment: "Gehaltserhöhung genehmigt."
                )
                mab3.save(flush: true, failOnError: true)

                println "Created ${MAB.count()} MAB entries"

                // 8. MAB Rollen zuweisen
                println "Creating MAB Role assignments..."
                def mabRole1 = new MABRole(
                        mab: mab1,
                        role: roleMitarbeiter,
                        empNum: 12345,
                        login: "mmueller",
                        lastName: "Müller",
                        firstName: "Max",
                        mail: "max.mueller@firma.ch",
                        hasApproved: false
                )
                mabRole1.save(flush: true, failOnError: true)

                def mabRole2 = new MABRole(
                        mab: mab1,
                        role: roleVorgesetzter,
                        empNum: 11001,
                        login: "aschmidt",
                        lastName: "Schmidt",
                        firstName: "Anna",
                        mail: "anna.schmidt@firma.ch",
                        hasApproved: false
                )
                mabRole2.save(flush: true, failOnError: true)

                println "Created ${MABRole.count()} MAB Role assignments"

                // 9. MAB Kompetenzen zuweisen
                println "Creating MAB Competence assignments..."
                def mabComp1 = new MABCompetence(
                        mab: mab1,
                        competence: kompFachlich,
                        rating: rating5_4,
                        descriptionText: "Hervorragende Kenntnisse in Java und Spring Framework.",
                        assessmentText: "Entwickelt qualitativ hochwertigen Code."
                )
                mabComp1.save(flush: true, failOnError: true)

                def mabComp2 = new MABCompetence(
                        mab: mab2,
                        competence: kompFuehrung,
                        rating: rating3_3,
                        descriptionText: "Exzellente Führungsqualitäten.",
                        assessmentText: "Hervorragende Führungspersönlichkeit."
                )
                mabComp2.save(flush: true, failOnError: true)

                println "Created ${MABCompetence.count()} MAB Competence assignments"

                println "=== DEMO DATA SUMMARY ==="
                println "MAB Status: ${MABStatus.count()}"
                println "Roles: ${Role.count()}"
                println "Rating Scales: ${RatingScale.count()}"
                println "Ratings: ${Rating.count()}"
                println "Competencies: ${Competence.count()}"
                println "MABs: ${MAB.count()}"
                println "MAB Roles: ${MABRole.count()}"
                println "MAB Competences: ${MABCompetence.count()}"
                println "=== DEMO DATA CREATED SUCCESSFULLY ==="

            } else {
                println "Demo data already exists, skipping creation..."
                println "Current data counts:"
                println "MAB Status: ${MABStatus.count()}"
                println "Roles: ${Role.count()}"
                println "MABs: ${MAB.count()}"
            }

        } catch (Exception e) {
            println "ERROR in BootStrap: ${e.message}"
            e.printStackTrace()
            log.error "BootStrap failed", e
        }

        println "=== BOOTSTRAP COMPLETED ==="
    }

    def destroy = {
    }
}