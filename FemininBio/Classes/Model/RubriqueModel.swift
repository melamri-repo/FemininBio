//
//  Rubrique.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
struct RubriqueModel: Codable {
    var idRubrique: Int?
    var name: String?
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case idRubrique = "id"
        case name = "n"
    }
    /// init from decoderÒ
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: error
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idRubrique = try values.decodeIfPresent(Int.self, forKey: .idRubrique)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    /// Encode
    ///
    /// - Parameter encoder: Encoder
    /// - Throws: error
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idRubrique, forKey: .idRubrique)
        try container.encode(name, forKey: .name)
    }
}
