//
//  MainViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit
class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tvc = WhyNeedDrinkWaterController()
        let articles = UITabBarItem(title: "Статьи", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart"))
        tvc.tabBarItem = articles
        
        let svc = UINavigationController(rootViewController: SummaryViewController{ _ in })
        svc.navigationBar.backgroundColor  = .white
        let summary = UITabBarItem(title: "Обзор", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
        svc.tabBarItem = summary
        self.navigationItem.titleView?.isHidden = true
        
        let pvc = UINavigationController(rootViewController: ProfileViewController())
        let profile = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        pvc.tabBarItem = profile
        pvc.tabBarItem = profile
        self.viewControllers = [svc,pvc, tvc]
    }

}

