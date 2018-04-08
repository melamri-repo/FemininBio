//
//  ArticleDetailsViewController.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ArticleDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var resumeLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: -Rx Variables
    var disposeBag = DisposeBag()
    var isSuccess: BehaviorRelay<(Bool,String)> = BehaviorRelay(value: (false,""))
    var articleDetails: BehaviorRelay<ArticleDetailsModel> = BehaviorRelay(value: ArticleDetailsModel())
    // MARK: -Variables
    var idArticle: Int?
    let articleClient = ArticleClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addObserverOnArticleDetails()
        getArticleById()

    }
    func getArticleById() {
        self.activityIndicator.startAnimating()
        articleClient.getArticleDetails(articleDetails: articleDetails, isSuccess: isSuccess, articleId: idArticle!)
    }
    func addObserverOnArticleDetails(){
        self.articleDetails.asObservable().subscribe(onNext: { (articleReturned) in
            self.setupView()
            self.activityIndicator.stopAnimating()
        }, onError: { (_) in

        }).disposed(by: disposeBag)
    }
    func setupView() {
        titleLabel.text = articleDetails.value.titre
        if let url = articleDetails.value.image?.url {
            articleImage.image = GlobalHelper.sharedInstance.imageFromUrl(urlString: url)
        }
        subTitleLabel.text = articleDetails.value.surTitre
        if let corps = articleDetails.value.corpsArticle {
            bodyLabel.attributedText = GlobalHelper.sharedInstance.stringFromHtml(string: corps)
        }
        resumeLabel.text = articleDetails.value.accroche
        authorLabel.text = articleDetails.value.auteur?.name
        if let date = articleDetails.value.dateArticle {
            dateLabel.text = GlobalHelper.sharedInstance.formatDate(withTimeStamp: date)
        }

    }
    
}
