//
//  SummaryViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentNumberOfCupsOfWater : Int = 10
    var goalOfNumberOfCupsOfWater  : Int = 25
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentNumberOfCupsOfWater + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCollectionViewCell", for: indexPath) as! CupCollectionViewCell
        
        if indexPath[1] + 1 == currentNumberOfCupsOfWater + 1 {
            
            cell.cellForAdd()
        } else {
            cell.defaultCell()
        }
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath[1] + 1 == currentNumberOfCupsOfWater + 1 {
            currentNumberOfCupsOfWater += 1
            collectionView.insertItems(at: [indexPath])
            
            let lastSection = collectionView.numberOfSections - 1
            let lastRow = collectionView.numberOfItems(inSection: lastSection)
            let indexPath = IndexPath(row: lastRow - 1, section: lastSection)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            
            
        } else {
            currentNumberOfCupsOfWater -= 1
            collectionView.deleteItems(at: [indexPath])
            
        }
        
        waterProgressBar.setValue(Float(currentNumberOfCupsOfWater) / Float(goalOfNumberOfCupsOfWater),
                                  animated: true)
        CurrentCuplabel.text = "Выпито: \(currentNumberOfCupsOfWater)/\(goalOfNumberOfCupsOfWater)"
    }
    
    let glassChecker: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CupCollectionViewCell.self, forCellWithReuseIdentifier: "CupCollectionViewCell")
        collection.backgroundColor = .white
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
    
    
    let CurrentCuplabel = UILabel()
        
    let ChampionLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Текущая серия 72 дня\n Это рекорд 💪"
        label.numberOfLines = 3
        label.layer.cornerRadius = 13
        label.clipsToBounds = true;
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
//        label.contentMode = .center
        return label
    }()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentCuplabel.text = "Выпито: \(currentNumberOfCupsOfWater)/\(goalOfNumberOfCupsOfWater)"
        CurrentCuplabel.textAlignment = .natural
        CurrentCuplabel.font = .boldSystemFont(ofSize: 24)
        CurrentCuplabel.translatesAutoresizingMaskIntoConstraints = false
        CurrentCuplabel.backgroundColor = .clear
        
        let progressLabel = UIView()
        progressLabel.backgroundColor = .white
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.addSubview(CurrentCuplabel)
        let constraints = [
            CurrentCuplabel.leftAnchor.constraint(equalTo: progressLabel.leftAnchor, constant: 16),
            CurrentCuplabel.topAnchor.constraint(equalTo: progressLabel.topAnchor, constant: 16),
            CurrentCuplabel.rightAnchor.constraint(equalTo: progressLabel.rightAnchor),
            CurrentCuplabel.bottomAnchor.constraint(equalTo: progressLabel.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        waterProgressBar.setValue(Float(currentNumberOfCupsOfWater) / Float(goalOfNumberOfCupsOfWater),
                                  animated: true)
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
            glassChecker.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraints_glassChecker)
        view.addSubview(ChampionLabel)
        let ChampionLabel_constraints =
        [ ChampionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
          ChampionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
          ChampionLabel.topAnchor.constraint(equalTo: glassChecker.bottomAnchor, constant: 12),
          ChampionLabel.heightAnchor.constraint(equalTo: glassChecker.heightAnchor)
            
        ]
        NSLayoutConstraint.activate(ChampionLabel_constraints)
    }
}

