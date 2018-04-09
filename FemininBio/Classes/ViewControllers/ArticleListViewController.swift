//
//  ArticleListeViewController.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ArticleListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    // MARK: -Rx Variables
    var disposeBag = DisposeBag()
    var isSuccess: BehaviorRelay<(Bool,String)> = BehaviorRelay(value: (false,""))
    var articles: BehaviorRelay<[ArticleModel]> = BehaviorRelay(value: [ArticleModel]())
    // MARK: Variables
    let articleClient = ArticleClient()
    var pageNumber: Int = 0
    var isMoreNews: Bool = false
    var articleList: [ArticleModel] = []
    private let tableViewRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNagivationItem()
        initTableView()
        // Register notifications
        registerObservers()
        // Rx Functions
        addObserverOnArticles()
        getArticles()
        bindArticles()
        didSelectAtArticleRow()
    }
    /// Register observers
    func registerObservers() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loadMoreNews"), object: nil, queue: nil) { (notification) in
            self.activityIndicator.startAnimating()
            self.isMoreNews = true
            self.articleClient.getArticlesByPage(articles: self.articles, isSuccess: self.isSuccess, pageNumber: self.pageNumber+1)
        }
    }
    /// set navigation settings
    func setupNagivationItem() {
        self.navigationItem.title = "A la une"
    }
    /// Init the tableview
    private func initTableView() {
        // Setup the tableview style
        self.tableView.alwaysBounceVertical = true
        // -> Prevent empty rows
        self.tableView.tableFooterView = UIView()
        // Add the refresh control
        self.tableViewRefreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.tableView.refreshControl = self.tableViewRefreshControl
        // Register cell
        self.tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        // Set Rx delegate
        self.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        // Do not set datasource to prevent xcode from crashing
    }
    /// setup footer when articles is not empty
    func setupFooterWhenData() {
        // Custom Footer
        let footerView = Bundle.main.loadNibNamed("ArticleTableViewFooter", owner: self, options: nil)![0] as! ArticleTableViewFooter
        footerView.frame = CGRect(x: 0, y: tableView.frame.size.height - 20, width: tableView.frame.size.width, height: 20)
        self.tableView.tableFooterView = footerView
    }
    /// Refresh List of Velib
    @objc private func refreshList() {
        getArticles()
    }
    /// get all velibs from datasource
    func getArticles() {
        self.activityIndicator.startAnimating()
        articleClient.getArticles(articles: articles, isSuccess: isSuccess)
    }
    /// add observer on article lists
    func addObserverOnArticles() {
        self.articles.asObservable().subscribe(onNext: { (articlesReturned) in
            // show noDataLabel depending on articles count
            if self.articles.value.isEmpty {
                //self.noDataLabel.isHidden = false
            } else {
                //self.noDataLabel.isHidden = true
                self.setupFooterWhenData()
            }
            self.tableView.reloadData()
            self.tableViewRefreshControl.endRefreshing()
            if self.isMoreNews {
                self.isMoreNews = false
                self.pageNumber += 1
            }
            self.activityIndicator.stopAnimating()
        }, onError: { (_) in

        }).disposed(by: disposeBag)
    }
    /// Bind tableview with threads
    private func bindArticles() {
        self.articles.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "ArticleTableViewCell")) {  _, article, cell in
                if let articleCell = cell as? ArticleTableViewCell {
                    articleCell.setupArticleCell(article: article)
                }
            }.disposed(by: disposeBag)
    }
    /// Setup the thread cell tap handling
    private func didSelectAtArticleRow() {
        self.tableView
            .rx
            .modelSelected(ArticleModel.self)
            .subscribe(onNext: { article in
                if self.tableView.indexPathForSelectedRow != nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let detailsController = storyboard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
                    detailsController.title = "Détail de l'article: \(article.surTitre ?? "")"
                    let backItem = UIBarButtonItem()
                    backItem.title = "Retour"
                    detailsController.navigationItem.backBarButtonItem = backItem
                    detailsController.idArticle = article.idArticle
                    self.navigationController?.pushViewController(detailsController, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    // MARK: -TableViewDelegate
    /// set the height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
