//
//  ArticleTableViewFooter.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 09/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import UIKit
class ArticleTableViewFooter: UIView {
    @IBOutlet weak var moreNewsButton: UIButton!
    @IBAction func loadMoreNews(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("loadMoreNews"), object: nil, userInfo: nil)
    }
}
