class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // Root URL mapping - redirect to MAB controller (note: lowercase 'mAB' matches MABController)
        "/"(controller: 'mab', action: 'index')

        // Error pages
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}