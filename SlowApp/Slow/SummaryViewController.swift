//
//  SummaryViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController {
    
//    let glassChecker: UICollectionView = {
//        let collection = UICollectionView()
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        
//        return collection
//        
//    }()
    
    let SummaryLabel : UILabel = {
        let label = UILabel()
        label.text = "Обзор"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    let waterProgressBar : UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .clear
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isUserInteractionEnabled = false
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.value = 0.5
        slider.backgroundColor = .white
        slider.tintColor = UIColor(red: 168/255, green: 245/255, blue: 242/255, alpha: 1)
//        slider.track
        return slider
    }()
    let progressLabel : UIView = {
        let label = UILabel()
        label.text = "Выпито: 0/10"
        label.textAlignment = .natural
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        
        let back = UIView()
        back.backgroundColor = .white
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addSubview(label)
        let constraints = [
            label.leftAnchor.constraint(equalTo: back.leftAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: back.topAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: back.rightAnchor),
            label.bottomAnchor.constraint(equalTo: back.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return back
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.view.backgroundColor = UIColor(cgColor:
                                        CGColor(srgbRed: 244, green: 244, blue: 244, alpha: 0.95))
        self.navigationItem.titleView = SummaryLabel
        
        self.view.addSubview(progressLabel)
        let constraints_progressLabel =
        [
            progressLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 0),
            progressLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            progressLabel.heightAnchor.constraint(equalToConstant: 48),
            progressLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints_progressLabel)

        
        self.view.addSubview(waterProgressBar)
        let constraints_waterProgressBar =
        [
            waterProgressBar.leftAnchor.constraint(equalTo:
                                                    view.leftAnchor, constant: 16),
         waterProgressBar.rightAnchor.constraint(equalTo:
                                                    view.rightAnchor, constant: -16),
         waterProgressBar.topAnchor.constraint(equalTo:
                                                self.view.safeAreaLayoutGuide.topAnchor, constant: 1),
         waterProgressBar.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(constraints_waterProgressBar)
 
    }
}
