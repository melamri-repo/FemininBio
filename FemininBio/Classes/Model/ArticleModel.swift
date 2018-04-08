//
//  ArticleModel.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 05/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
struct ArticleModel: Codable {
    var idArticle: Int?
    var dateArticle: Int?
    var surTitre: String?
    var titre: String?
    var titreLong: String?
    var rubrique: RubriqueModel?
    var sousRubrique: RubriqueModel?
    var auteur: AuteurModel?
    var accroche: String?
    var corpsArticle: String?
    var image: ImageModel?
    var articleLies: [ArticleModel]?
    var theme: String?
    var nc: Int?
    var ty: [String]?
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case idArticle = "id"
        case dateArticle = "d"
        case surTitre = "st"
        case titre = "t"
        case titreLong = "tl"
        case rubrique = "r"
        case sousRubrique = "sr"
        case auteur = "a"
        case accroche = "ch"
        case corpsArticle = "co"
        case image = "i"
        case articleLies = "al"
        case theme = "th"
        case nc
        case ty
    }
    /// init from decoder
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: error
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idArticle = try values.decodeIfPresent(Int.self, forKey: .idArticle)
        dateArticle = try values.decodeIfPresent(Int.self, forKey: .dateArticle)
        surTitre = try values.decodeIfPresent(String.self, forKey: .surTitre)
        titre = try values.decodeIfPresent(String.self, forKey: .titre)
        titreLong = try values.decodeIfPresent(String.self, forKey: .titreLong)
        rubrique = try values.decodeIfPresent(RubriqueModel.self, forKey: .rubrique)
        sousRubrique = try values.decodeIfPresent(RubriqueModel.self, forKey: .sousRubrique)
        auteur = try values.decodeIfPresent(AuteurModel.self, forKey: .auteur)
        accroche = try values.decodeIfPresent(String.self, forKey: .accroche)
        corpsArticle = try values.decodeIfPresent(String.self, forKey: .corpsArticle)
        image = try values.decodeIfPresent(ImageModel.self, forKey: .image)
        articleLies = try values.decodeIfPresent([ArticleModel].self, forKey: .articleLies)
        theme = try values.decodeIfPresent(String.self, forKey: .theme)
        nc = try values.decodeIfPresent(Int.self, forKey: .nc)
        ty = try values.decodeIfPresent([String].self, forKey: .ty)
    }
    /// Encode
    ///
    /// - Parameter encoder: Encoder
    /// - Throws: error
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idArticle, forKey: .idArticle)
        try container.encode(dateArticle, forKey: .dateArticle)
        try container.encode(surTitre, forKey: .surTitre)
        try container.encode(titre, forKey: .titre)
        try container.encode(titreLong, forKey: .titreLong)
        try container.encode(rubrique, forKey: .rubrique)
        try container.encode(sousRubrique, forKey: .sousRubrique)
        try container.encode(auteur, forKey: .auteur)
        try container.encode(accroche, forKey: .accroche)
        try container.encode(corpsArticle, forKey: .corpsArticle)
        try container.encode(image, forKey: .image)
        try container.encode(articleLies, forKey: .articleLies)
        try container.encode(theme, forKey: .theme)
        try container.encode(nc, forKey: .nc)
        try container.encode(ty, forKey: .ty)
    }
}

/*{
 "id":92782,
 "st":"Jeu-concours",
 "t":"Jeu-concours \u0022 le bon plan bio\u0022 avec Aboneobio",
 "tl":"Jeu-concours \u0022 le bon plan bio\u0022 avec Aboneobio",
 "d":1522854966,
 "r":{
 "id":4,
 "n":"Maison \u0026 Jardin"
 },
 "sr":{
 "id":29,
 "n":"Test produit"
 },
 "ty":[
 
 ],
 "a":{
 "id":245779,
 "n":"Publir\u00e9dactionnel",
 "u":"https:\/\/www.femininbio.com\/sites\/femininbio.com\/files\/pictures\/picture-245779-1361523946.jpg"
 },
 "ch":"Du 9 au 30 avril, participez au jeu-concours pour tenter de gagner 1 an de produits cosm\u00e9tiques, d\u0027hygi\u00e8ne et d\u0027entretien de la maison offert par Aboneobio !",
 "i":{
 "u":"https:\/\/www.femininbio.com\/sites\/femininbio.com\/files\/images\/2018\/04\/illustration3.png",
 "a":"",
 "l":"",
 "c":""
 },
 "nc":1
 }*/
