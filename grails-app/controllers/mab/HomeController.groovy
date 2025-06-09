package mab

class HomeController {

    def index() {
        // Weiterleitung zu Mab-Controller
        redirect(controller: "mab", action: "index")
    }
}