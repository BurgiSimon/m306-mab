package mab

class MABRole {
    MAB mab
    Role role
    Integer empNum
    String login
    String lastName
    String firstName
    String mail
    Boolean hasApproved = false
    Date approvedDate

    static constraints = {
        mab nullable: false
        role nullable: false
        empNum nullable: true
        login nullable: true, maxSize: 50
        lastName nullable: true, maxSize: 50
        firstName nullable: true, maxSize: 50
        mail nullable: true, maxSize: 100, email: true
        hasApproved nullable: false
        approvedDate nullable: true
    }

    static mapping = {
        table 'tMABRole'
        id column: 'idMABRole'
        mab column: 'tMABId'
        role column: 'tRoleId'
        version false
    }

    String toString() {
        return "${firstName} ${lastName} (${role})"
    }
}