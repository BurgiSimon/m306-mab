package mab

class HomeController {

    def index() {
        // Weiterleitung zu MAB-Controller
        redirect(controller: "MAB", action: "index")
    }
}