//
//  ArticleDetailsViewController.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Foundation

import UIKit

class ArticleDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var resumeLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
