class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // Direkt zu MAB weiterleiten
        "/"(controller: 'MAB', action: 'index')

        // Error pages
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}