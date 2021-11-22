//
//  CupsTableViewCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit

class CupsTableViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cups = [
        UIImage(named: "blood"),
        UIImage(named: "beer"),
        UIImage(named: "classic"),
        UIImage(named: "rose"),
        UIImage(named: "noire"),
        UIImage(named: "default"),
        UIImage(named: "blood"),
        UIImage(named: "beer"),
        UIImage(named: "classic"),
        UIImage(named: "rose"),
        UIImage(named: "noire"),
        UIImage(named: "default"),
        UIImage(named: "blood"),
        UIImage(named: "beer"),
        UIImage(named: "classic"),
        UIImage(named: "rose"),
        UIImage(named: "noire"),
        UIImage(named: "default")
    ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {

                return CGSize(width: 80, height: 80)
        }
                
            
        
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    let cupsLabel : UILabel = {
        let label = UILabel()
        label.text = "Доступные стаканы"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCollectionViewCell", for: indexPath) as! CupCollectionViewCell
        
        cell.image.image = cups[indexPath[1]]
        cell.closeImageView.isHidden = true

        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
   
    
    let allItems: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let width = 80
        layout.itemSize = CGSize(width:width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CupCollectionViewCell.self, forCellWithReuseIdentifier: "CupCollectionViewCell")
        
        collection.backgroundColor = .white
        return collection
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        allItems.dataSource = self
        allItems.delegate = self
        allItems.layer.cornerRadius = 13
        self.addSubview(cupsLabel)
        self.addSubview(allItems)
        self.layer.cornerRadius = 13
        self.backgroundColor  = .white
        allItems.isScrollEnabled = true
        let constraint = [
            cupsLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
            cupsLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            cupsLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            allItems.leftAnchor.constraint(equalTo: self.leftAnchor),
            allItems.topAnchor.constraint(equalTo: cupsLabel.bottomAnchor),
            allItems.rightAnchor.constraint(equalTo: self.rightAnchor),
            allItems.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraint)
        
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
