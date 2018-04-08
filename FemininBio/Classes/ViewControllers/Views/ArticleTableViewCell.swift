//
//  ArticleTableViewCell.swift
//  FemininBio
//
//  Created by cluster SIG on 07/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import UIKit
class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rubriqueLabel: UILabel!
    @IBOutlet weak var articleImg: UIImageView!
    func setupArticleCell(article: ArticleModel) {
        titleLabel.text = article.titre
        rubriqueLabel.text = article.rubrique?.name
        if let url = article.image?.url {
            articleImg.image = GlobalHelper.sharedInstance.imageFromUrl(urlString: url)
        }
    }
}
