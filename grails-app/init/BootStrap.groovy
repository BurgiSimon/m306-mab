import mab.*
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Date

class BootStrap {

    def init = { servletContext ->

        println "=== BOOTSTRAP STARTING ==="
        log.info "BootStrap init started..."

        try {
            MABStatus.withTransaction { status ->
                if (MABStatus.count() == 0) {
                    println "Creating demo data..."
                    log.info "Creating demo data..."

                    // 1. MAB Status erstellen
                    println "Creating MAB Status..."
                    def statusBewertung = new MABStatus(mabStatusName: "Bewertung Vorgesetzter").save(failOnError: true)
                    def statusFreigabe = new MABStatus(mabStatusName: "Freigabe Supervisor").save(failOnError: true)
                    def statusGespraech = new MABStatus(mabStatusName: "MA-Gespräch").save(failOnError: true)
                    def statusSignieren = new MABStatus(mabStatusName: "MAB Signieren").save(failOnError: true)
                    def statusAbgeschlossen = new MABStatus(mabStatusName: "MAB abgeschlossen").save(failOnError: true)
                    println "Created ${MABStatus.count()} MAB Status entries"

                    // 2. Rollen erstellen
                    println "Creating Roles..."
                    def roleVorgesetzter = new Role(roleName: "Vorgesetzter").save(failOnError: true)
                    def roleMitarbeiter = new Role(roleName: "Mitarbeiter").save(failOnError: true)
                    def roleSupervisor = new Role(roleName: "Supervisor").save(failOnError: true)
                    def roleHR = new Role(roleName: "HR").save(failOnError: true)
                    println "Created ${Role.count()} Roles"

                    // 3. Rating Scale erstellen
                    println "Creating Rating Scales..."
                    def ratingScale5 = new RatingScale(ratingScaleName: "5-Punkte-Skala", sortOrder: 1).save(failOnError: true)
                    def ratingScale3 = new RatingScale(ratingScaleName: "3-Punkte-Skala", sortOrder: 2).save(failOnError: true)
                    println "Created ${RatingScale.count()} Rating Scales"

                    // 4. Ratings für 5-Punkte-Skala
                    println "Creating Ratings..."
                    def rating5_1 = new Rating(ratingScale: ratingScale5, ratingName: "Ungenügend", points: 1, sortOrder: 1).save(failOnError: true)
                    def rating5_2 = new Rating(ratingScale: ratingScale5, ratingName: "Mangelhaft", points: 2, sortOrder: 2).save(failOnError: true)
                    def rating5_3 = new Rating(ratingScale: ratingScale5, ratingName: "Befriedigend", points: 3, sortOrder: 3).save(failOnError: true)
                    def rating5_4 = new Rating(ratingScale: ratingScale5, ratingName: "Gut", points: 4, sortOrder: 4).save(failOnError: true)
                    def rating5_5 = new Rating(ratingScale: ratingScale5, ratingName: "Sehr gut", points: 5, sortOrder: 5).save(failOnError: true)

                    // 5. Ratings für 3-Punkte-Skala
                    def rating3_1 = new Rating(ratingScale: ratingScale3, ratingName: "Unter Erwartung", points: 1, sortOrder: 1).save(failOnError: true)
                    def rating3_2 = new Rating(ratingScale: ratingScale3, ratingName: "Erfüllt Erwartung", points: 2, sortOrder: 2).save(failOnError: true)
                    def rating3_3 = new Rating(ratingScale: ratingScale3, ratingName: "Übertrifft Erwartung", points: 3, sortOrder: 3).save(failOnError: true)
                    println "Created ${Rating.count()} Ratings"

                    // 6. Kompetenzen erstellen
                    println "Creating Competencies..."
                    def kompFachlich = new Competence(ratingScale: ratingScale5, competenceName: "Fachliche Kompetenz", competenceActive: true).save(failOnError: true)
                    def kompSozial = new Competence(ratingScale: ratingScale5, competenceName: "Soziale Kompetenz", competenceActive: true).save(failOnError: true)
                    def kompKommunikation = new Competence(ratingScale: ratingScale5, competenceName: "Kommunikation", competenceActive: true).save(failOnError: true)
                    def kompFuehrung = new Competence(ratingScale: ratingScale3, competenceName: "Führungskompetenz", competenceActive: true).save(failOnError: true)
                    def kompTeamwork = new Competence(ratingScale: ratingScale5, competenceName: "Teamarbeit", competenceActive: true).save(failOnError: true)
                    println "Created ${Competence.count()} Competencies"

                    // 7. Demo MABs erstellen
                    println "Creating MAB entries..."
                    def formatter = DateTimeFormatter.ofPattern('dd.MM.yyyy')
                    def now = LocalDate.now()

                    def mab1 = new MAB(
                            mabStatus: statusBewertung,
                            assessmentFrom: Date.from(LocalDate.parse('01.01.2024', formatter).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            assessmentTo: Date.from(LocalDate.parse('31.12.2024', formatter).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            commentText: "Jährliche Leistungsbeurteilung für Software Entwickler. Fokus auf technische Fähigkeiten und Projektmitarbeit.",
                            isOnlineApproval: true,
                            // *** FIX: Use java.time for date arithmetic ***
                            createDate: Date.from(now.minusDays(30).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            appraiseeComment: "Ich habe dieses Jahr viel über neue Technologien gelernt.",
                            supervisorComment: "Sehr zuverlässiger Mitarbeiter mit ausgezeichneten technischen Fähigkeiten."
                    ).save(failOnError: true)

                    def mab2 = new MAB(
                            mabStatus: statusFreigabe,
                            assessmentFrom: Date.from(LocalDate.parse('01.07.2023', formatter).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            assessmentTo: Date.from(LocalDate.parse('30.06.2024', formatter).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            commentText: "Beurteilung der Projektmanagement-Kompetenzen und Führungsleistung.",
                            isOnlineApproval: true,
                            // *** FIX: Use java.time for date arithmetic ***
                            createDate: Date.from(now.minusDays(60).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            appraiseeComment: "Habe mehrere Projekte erfolgreich geleitet.",
                            supervisorComment: "Hervorragende Führungsqualitäten.",
                            hrComment: "Empfehlung für Beförderung."
                    ).save(failOnError: true)

                    def mab3 = new MAB(
                            mabStatus: statusAbgeschlossen,
                            assessmentFrom: Date.from(LocalDate.parse('01.01.2023', formatter).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            assessmentTo: Date.from(LocalDate.parse('31.12.2023', formatter).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            commentText: "Vollständige Jahresbeurteilung mit Fokus auf Führungskompetenzen.",
                            isOnlineApproval: true,
                            // *** FIX: Use java.time for date arithmetic ***
                            createDate: Date.from(now.minusDays(120).atStartOfDay().atZone(java.time.ZoneId.systemDefault()).toInstant()),
                            appraiseeComment: "War ein erfolgreiches Jahr.",
                            supervisorComment: "Ausgezeichnete Leistung in allen Bereichen.",
                            hrComment: "Gehaltserhöhung genehmigt."
                    ).save(failOnError: true)
                    println "Created ${MAB.count()} MAB entries"

                    // 8. MAB Rollen zuweisen
                    println "Creating MAB Role assignments..."
                    new MABRole(
                            mab: mab1,
                            role: roleMitarbeiter,
                            empNum: 12345,
                            login: "mmueller",
                            lastName: "Müller",
                            firstName: "Max",
                            mail: "max.mueller@firma.ch",
                            hasApproved: false
                    ).save(failOnError: true)

                    new MABRole(
                            mab: mab1,
                            role: roleVorgesetzter,
                            empNum: 11001,
                            login: "aschmidt",
                            lastName: "Schmidt",
                            firstName: "Anna",
                            mail: "anna.schmidt@firma.ch",
                            hasApproved: false
                    ).save(failOnError: true)
                    println "Created ${MABRole.count()} MAB Role assignments"

                    // 9. MAB Kompetenzen zuweisen
                    println "Creating MAB Competence assignments..."
                    new MABCompetence(
                            mab: mab1,
                            competence: kompFachlich,
                            rating: rating5_4,
                            descriptionText: "Hervorragende Kenntnisse in Java und Spring Framework.",
                            assessmentText: "Entwickelt qualitativ hochwertigen Code."
                    ).save(failOnError: true)

                    new MABCompetence(
                            mab: mab2,
                            competence: kompFuehrung,
                            rating: rating3_3,
                            descriptionText: "Exzellente Führungsqualitäten.",
                            assessmentText: "Hervorragende Führungspersönlichkeit."
                    ).save(failOnError: true)
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
                }
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