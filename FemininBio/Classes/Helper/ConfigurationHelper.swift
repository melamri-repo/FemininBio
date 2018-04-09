//
//  ConfigurationHelper.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 05/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import UIKit

/// ConfigurationHelper
class ConfigurationHelper {
    /// getConfigForKey
    ///
    /// - Parameter key: String
    /// - Returns: String
    static func getConfigForKey(key: String) -> String {
        // we obtain path if path we obtain dictionnary from configuration file if dic get key value
        // correction of unwrapping nil
        if let path: String = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: path) as? [String: Any],
            let value = dic[key] as? String {
            return value
        }
        return ""
    }
}
