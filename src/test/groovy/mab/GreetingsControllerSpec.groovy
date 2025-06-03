package mab

import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class GreetingsControllerSpec extends Specification implements ControllerUnitTest<GreetingsController> {

     void "test index action"() {
        when:
        controller.index()

        then:
        status == 200

     }
}
