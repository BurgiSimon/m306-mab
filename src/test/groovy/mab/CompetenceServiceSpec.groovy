package mab

import grails.testing.services.ServiceUnitTest
import spock.lang.Specification

class CompetenceServiceSpec extends Specification implements ServiceUnitTest<CompetenceService>{

    def setup() {
    }

    def cleanup() {
    }

    void "test service exists"() {
        expect:"service should exist"
        service != null
    }
}