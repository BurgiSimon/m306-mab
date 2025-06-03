package mab

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class MABStatusSpec extends Specification implements DomainUnitTest<MABStatus> {

     void "test domain constraints"() {
        when:
        MABStatus domain = new MABStatus()
        //TODO: Set domain props here

        then:
        domain.validate()
     }
}
