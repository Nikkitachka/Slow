//
//  CupsTableViewCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit

class CupsTableViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var numbers = 15
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {

                return CGSize(width: 80, height: 80)
        }
                
            
        
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCollectionViewCell", for: indexPath) as! CupCollectionViewCell
        
        cell.defaultCell()
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
        self.addSubview(allItems)
        allItems.backgroundColor  = .brown
        allItems.isScrollEnabled = false
        let constraint = [
            allItems.leftAnchor.constraint(equalTo: self.leftAnchor),
            allItems.topAnchor.constraint(equalTo: self.topAnchor),
            allItems.rightAnchor.constraint(equalTo: self.rightAnchor),
            allItems.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraint)
        
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
