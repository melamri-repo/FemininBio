//
//  AuteurModel.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
struct AuteurModel: Codable {
    var idAuteur: String?
    var name: String?
    var url: String?
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case idAuteur = "id"
        case name = "n"
        case url = "u"
    }
    /// init from decoder
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: error
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idAuteur = try values.decodeIfPresent(String.self, forKey: .idAuteur)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    /// Encode
    ///
    /// - Parameter encoder: Encoder
    /// - Throws: error
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idAuteur, forKey: .idAuteur)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
    /*"id":245779,
    "n":"Publir\u00e9dactionnel",
    "u":"https:\/\/www.femininbio.com\/sites\/femininbio.com\/files\/pictures\/picture-245779-1361523946.jpg"
    */
}
