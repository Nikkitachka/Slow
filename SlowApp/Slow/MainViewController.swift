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
//        let svc = UINavigationController(rootViewController: CalendarPickerViewController(baseDate: Date(), selectedDateChanged: { _ in } ))
        let svc = UINavigationController(rootViewController: SummaryViewController{ _ in })
        svc.navigationBar.backgroundColor  = .white
        
        

        
        let summary = UITabBarItem(title: "Обзор", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        svc.tabBarItem = summary
        self.navigationItem.titleView?.isHidden = true

        
        
        
        let pvc = UINavigationController(rootViewController: ProfileViewController())
        let profile = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        pvc.tabBarItem = profile
        
//        let pvc = UINavigationController(rootViewController: ProfileViewController())
//        let profile = UITabBarItem()
//        profile.title = "Profile"
        
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

