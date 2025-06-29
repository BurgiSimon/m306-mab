package mab

import grails.gorm.services.Service

@Service(MAB)
interface MabService {

    MAB get(Serializable id)

    List<MAB> list(Map args)

    Long count()

    void delete(Serializable id)

    MAB save(MAB mab)

}