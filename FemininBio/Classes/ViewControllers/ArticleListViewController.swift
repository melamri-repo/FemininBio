//
//  ArticleListeViewController.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation

import UIKit

class ArticleListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let tableViewRefreshControl = UIRefreshControl()
    // MARK: -Rx Variables
    var disposeBag = DisposeBag()
    var velibs: BehaviorRelay<[VelibModel]> = BehaviorRelay(value: [VelibModel]())
    var isSuccess: BehaviorRelay<(Bool,String)> = BehaviorRelay(value: (false,""))
    var filtredStands: BehaviorRelay<[VelibModel]> = BehaviorRelay(value: [VelibModel]())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        self.table.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: "")
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
        
    }
}
