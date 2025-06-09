class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // Root URL mapping - redirect to MAB controller
        "/"(controller: 'mab', action: 'index')

        // MAB specific mappings for enhanced functionality
        "/mab/$id/addCompetence"(controller: 'mab', action: 'addCompetence')
        "/mab/$id/addRole"(controller: 'mab', action: 'addRole')
        "/mab/saveCompetence"(controller: 'mab', action: 'saveCompetence')
        "/mab/saveRole"(controller: 'mab', action: 'saveRole')
        "/mab/updateStatus"(controller: 'mab', action: 'updateStatus')

        // API endpoints for potential AJAX calls
        "/api/mab/search"(controller: 'mab', action: 'index')
        "/api/competences"(controller: 'competence', action: 'index')

        // Error pages
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}