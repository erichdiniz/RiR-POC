//
//  WatsonMock.swift
//  RiR_POC
//
//  Created by Lucas Torquato on 24/06/19.
//  Copyright © 2019 Erich Diniz. All rights reserved.
//

import UIKit

class WatsonMock: NSObject {
    
    var questionText: String
    var responseText: String
    var responseType: ResponseType
    
    init(questionText: String, responseText: String, responseType: ResponseType) {
        self.questionText = questionText
        self.responseText = responseText
        self.responseType = responseType
    }
    
    static func createMocks() -> [WatsonMock] {
        return [
            WatsonMock(questionText: "Que horas começa o show do Foo Fighters?", responseText: "Fica ligado que faltam apenas 45 minutos pra começar a atração, gostaria de ser avisado quando começar?", responseType: ResponseType.schedule),
            WatsonMock(questionText: "O que é o Rock Street Asia?", responseText: "Rock Street Ásia será uma mostra de 5000 anos da história do mundo oriental. No espaço mais badalado do evento, a rua, com 200 metros de extensão fará um passeio pela arte, pelas tradições, pela cultura e promete fazer ainda uma apresentação lúdica da arquitetura destes povos.", responseType: ResponseType.normal),
            WatsonMock(questionText: "O que vai tocar no palco sunset hoje?", responseText: "", responseType: ResponseType.images),
            WatsonMock(questionText: "Qual o banheiro mais próximo?", responseText: "", responseType: ResponseType.maps)            
        ]
    }

}
