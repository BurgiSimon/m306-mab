package mab

class RatingScale {
    String ratingScaleName
    Integer sortOrder

    static constraints = {
        ratingScaleName nullable: false, blank: false, maxSize: 50
        sortOrder nullable: true
    }

    static mapping = {
        table 'tRatingScale'
        id generator: 'identity', column: 'idRatingScale'
        ratingScaleName column: 'RatingScaleName'
        sortOrder column: 'SortOrder'
        version false
    }

    String toString() {
        return ratingScaleName
    }
}