//
//  ArticleDetailsModel.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 05/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
struct ArticleDetailsModel: Codable {
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
    var theme: [ThemeModel]?
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
    }
    init() {

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
        theme = try values.decodeIfPresent([ThemeModel].self, forKey: .theme)
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
    }
}
