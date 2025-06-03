package mab

class MABCompetence {
    MAB mab
    Competence competence
    Rating rating
    String descriptionText
    String assessmentText

    static constraints = {
        mab nullable: false
        competence nullable: false
        rating nullable: true
        descriptionText nullable: true, maxSize: 1500
        assessmentText nullable: true, maxSize: 500
    }

    static mapping = {
        table 'tMABCompetence'
        id column: 'idMABCompetence'
        mab column: 'tMABId'
        competence column: 'tCompetenceId'
        rating column: 'tRatingId'
        version false
    }

    String toString() {
        return "${competence} - ${rating ?: 'Nicht bewertet'}"
    }
}