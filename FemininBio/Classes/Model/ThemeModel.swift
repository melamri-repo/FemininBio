//
//  ThemeModel.swift
//  FemininBio
//
//  Created by cluster SIG on 08/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
struct ThemeModel: Codable {
    var idTheme: String?
    var name: String?
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case idTheme = "id"
        case name = "n"
    }
    /// init from decoderÒ
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: error
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idTheme = try values.decodeIfPresent(String.self, forKey: .idTheme)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    /// Encode
    ///
    /// - Parameter encoder: Encoder
    /// - Throws: error
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idTheme, forKey: .idTheme)
        try container.encode(name, forKey: .name)
    }
}
