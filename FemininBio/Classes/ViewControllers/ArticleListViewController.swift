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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: -Rx Variables
    var disposeBag = DisposeBag()
    var isSuccess: BehaviorRelay<(Bool,String)> = BehaviorRelay(value: (false,""))
    var articles: BehaviorRelay<[ArticleModel]> = BehaviorRelay(value: [ArticleModel]())
    // MARK: Variables
    let articleClient = ArticleClient()
    private let tableViewRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTableView()
        addObserverOnArticles()
        getArticles()
        bindArticles()
        didSelectAtArticleRow()
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
    /// Refresh List of Velib
    @objc private func refreshList() {
        getArticles()
    }
    /// get all velibs from datasource
    func getArticles() {
        self.activityIndicator.startAnimating()
        articleClient.getArticles(articles: articles, isSuccess: isSuccess)
    }
    /// add observer on article lists : filtred and not filtred
    func addObserverOnArticles() {
        self.articles.asObservable().subscribe(onNext: { (articlesReturned) in
            self.tableView.reloadData()
            self.tableViewRefreshControl.endRefreshing()
            // show noDataLabel depending on filtredStands count
            if self.articles.value.isEmpty {
                //self.noDataLabel.isHidden = false
            } else {
                //self.noDataLabel.isHidden = true
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
