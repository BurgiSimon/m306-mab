package mab

class MABStatus {
    String mabStatusName

    static constraints = {
        mabStatusName nullable: false, blank: false, maxSize: 50
    }

    static mapping = {
        table 'tMABStatus'
        id generator: 'identity', column: 'idMABStatus'
        mabStatusName column: 'MABStatusName'
        version false
    }

    String toString() {
        return mabStatusName
    }
}