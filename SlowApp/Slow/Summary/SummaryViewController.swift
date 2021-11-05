//
//  SummaryViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCollectionViewCell", for: indexPath) as! CupCollectionViewCell
        
    
        cell.backgroundColor = .black
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    let glassChecker: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CupCollectionViewCell.self, forCellWithReuseIdentifier: "CupCollectionViewCell")
        collection.backgroundColor = .red
        return collection
        
    }()
    
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
        
        glassChecker.dataSource = self
        glassChecker.delegate = self
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
        
        self.view.addSubview(glassChecker)
        let constraints_glassChecker = [
            glassChecker.leftAnchor.constraint(equalTo: view.leftAnchor),
            glassChecker.rightAnchor.constraint(equalTo: view.rightAnchor),
            glassChecker.topAnchor.constraint(equalTo: progressLabel.bottomAnchor),
            glassChecker.heightAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(constraints_glassChecker)
        
 
    }
}

