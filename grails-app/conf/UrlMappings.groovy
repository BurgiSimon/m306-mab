class UrlMappings {

    static mappings = {
        // Standard Controller/Action Mapping
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // Startseite - Home Controller verwenden
        "/"(controller: "home", action: "index")

        // Spezielle MAB-Routen
        "/mab/$id/addCompetence"(controller: "MAB", action: "addCompetence")
        "/mab/saveCompetence"(controller: "MAB", action: "saveCompetence")

        // Error pages
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}