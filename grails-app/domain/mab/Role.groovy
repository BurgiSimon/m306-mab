package mab

class Role {
    String roleName

    static constraints = {
        roleName nullable: false, blank: false, maxSize: 50
    }

    static mapping = {
        table 'tRole'
        id generator: 'identity', column: 'idRole'
        roleName column: 'RoleName'
        version false
    }

    String toString() {
        return roleName
    }
}