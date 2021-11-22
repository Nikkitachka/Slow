//
//  MainViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit
var first = true
class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let svc = UINavigationController(rootViewController: SummaryViewController())
  
        svc.navigationBar.backgroundColor  = .white
        
        

        let summary = UITabBarItem()
        summary.title = "Summary"
        svc.tabBarItem = summary
        self.navigationItem.titleView?.isHidden = true
//        вставьте свое
//        item.image = UIImage(named: "home_icon")
        
        
        
        
        
        let pvc = UINavigationController(rootViewController: ProfileViewController())
        let profile = UITabBarItem()
        profile.title = "Profile"
        
        pvc.tabBarItem = profile
        self.viewControllers = [svc,pvc]
        
        
        
    }
    
    //Go to SignUpController at start
    override func viewDidAppear(_ animated: Bool) {
        // MARK: - TODO!!![[
        
        
            
        
        if first {
            let nextViewController = UINavigationController(rootViewController: SignUpController())
            self.present(nextViewController, animated:true, completion:nil)
            first = false
        }
    }
    
    
    
    
}

