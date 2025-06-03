package mab

class Competence {
    RatingScale ratingScale
    String competenceName
    Boolean competenceActive = true

    static constraints = {
        ratingScale nullable: false
        competenceName nullable: false, blank: false, maxSize: 50
        competenceActive nullable: false
    }

    static mapping = {
        table 'tCompetence'
        id column: 'idCompetence'
        ratingScale column: 'tRatingScaleId'
        version false
    }

    String toString() {
        return competenceName
    }
}