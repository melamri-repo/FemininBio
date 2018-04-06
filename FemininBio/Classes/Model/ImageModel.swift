//
//  ImageModel.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
struct ImageModel: Codable {
    var url: String?
    var a: String?
    var l: String?
    var c: String?
    /// CodingKeys
    enum CodingKeys: String, CodingKey {
        case l
        case a
        case c
        case url = "u"
    }
    /// init from decoder
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: error
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decodeIfPresent(String.self, forKey: .a)
        l = try values.decodeIfPresent(String.self, forKey: .l)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        c = try values.decodeIfPresent(String.self, forKey: .c)
    }
    /// Encode
    ///
    /// - Parameter encoder: Encoder
    /// - Throws: error
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(a, forKey: .a)
        try container.encode(l, forKey: .l)
        try container.encode(url, forKey: .url)
        try container.encode(c, forKey: .c)
    }
   /* "i":{
    "u":"https:\/\/www.femininbio.com\/sites\/femininbio.com\/files\/images\/2018\/04\/illustration3.png",
    "a":"",
    "l":"",
    "c":""
    }*/
}
