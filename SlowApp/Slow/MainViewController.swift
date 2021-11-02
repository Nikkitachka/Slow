//
//  MainViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit

class MainViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let svc = SummaryViewController()
        let summary = UITabBarItem()
        summary.title = "Summary"
        svc.tabBarItem = summary
        self.navigationItem.titleView?.isHidden = true
//        вставьте свое
//        item.image = UIImage(named: "home_icon")
        self.viewControllers = [svc]
        
    }
    
    
    
    
}
