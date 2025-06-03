package mab

class MAB {
    MABStatus mabStatus
    Date assessmentFrom
    Date assessmentTo
    String commentText
    Boolean isOnlineApproval = false
    Date createDate = new Date()
    String appraiseeComment
    String supervisorComment
    String hrComment

    static hasMany = [mabRoles: MABRole, mabCompetences: MABCompetence]

    static constraints = {
        mabStatus nullable: false
        assessmentFrom nullable: false
        assessmentTo nullable: false, validator: { val, obj ->
            if (obj.assessmentFrom && val <= obj.assessmentFrom) {
                return 'mab.assessmentTo.mustBeAfterFrom'
            }
        }
        commentText nullable: true, maxSize: 1000
        isOnlineApproval nullable: false
        createDate nullable: false
        appraiseeComment nullable: true, maxSize: 1000
        supervisorComment nullable: true, maxSize: 1000
        hrComment nullable: true, maxSize: 1000
    }

    static mapping = {
        table 'tMAB'
        id column: 'idMAB'
        mabStatus column: 'tMABStatusId'
        version false
    }

    String toString() {
        return "MAB ${id} (${assessmentFrom?.format('dd.MM.yyyy')} - ${assessmentTo?.format('dd.MM.yyyy')})"
    }
}