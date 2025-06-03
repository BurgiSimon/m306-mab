package mab

import grails.gorm.services.Service

@Service(Competence)
interface CompetenceService {

    Competence get(Serializable id)

    List<Competence> list(Map args)

    Long count()

    void delete(Serializable id)

    Competence save(Competence competence)

}