package mab

class Rating {
    RatingScale ratingScale
    String ratingName
    Integer points
    Integer sortOrder

    static constraints = {
        ratingScale nullable: false
        ratingName nullable: false, blank: false, maxSize: 50
        points nullable: true
        sortOrder nullable: true
    }

    static mapping = {
        table 'tRating'
        id column: 'idRating'
        ratingScale column: 'tRatingScaleId'
        version false
    }

    String toString() {
        return ratingName
    }
}