//
//  GlobalHelper.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
import UIKit
class GlobalHelper {
    static var sharedInstance = GlobalHelper()
    /// format Date from seconds to String with Format : HH:mm dd.MM.yyyy
    ///
    /// - Parameter numberOfSeconds: <#numberOfSeconds description#>
    /// - Returns: <#return value description#>
    func formatDate(withTimeStamp numberOfSeconds: Int) -> String {
        let timestamp = numberOfSeconds != 0 ? Int(numberOfSeconds) : Int(0.0)
        let timeInterval: TimeInterval = CDouble(timestamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.locale = NSLocale.current
        // we suppose that the format conforms to HH:mm dd.MM.yyyy
        let format = "HH:mm dd.MM.yyyy"
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
    /// UIImage from URL
    ///
    /// - Parameter urlString: <#urlString description#>
    /// - Returns: <#return value description#>
    func imageFromUrl(urlString: String) -> UIImage {
        var image = UIImage()
        if let url = URL(string: urlString) {
            if let data = try? NSData(contentsOf: url) as Data {
                if let img = UIImage(data: data) {
                    image = img
                }
            }
        }
        return image
    }
    /// AttributedString from HTML
    ///
    /// - Parameter string: <#string description#>
    /// - Returns: <#return value description#>
    func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
}
