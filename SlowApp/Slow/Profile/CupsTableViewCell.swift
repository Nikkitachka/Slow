//
//  CupsTableViewCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//
import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class CupsTableViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var selectedIndexPath :IndexPath = IndexPath(item: 0, section: 0)
    var level = 6
    let database = Database.database().reference()
    let cups = [
        "blood",
        "beer",
        "classic",
        "rose",
        "noire",
        "default"
    ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        level
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
        cell.image.image = UIImage(named: cups[indexPath[1]])
//        if indexPath == selectedIndexPath {
//            cell.backgroundColor = .black
//        } else {
//            cell.backgroundColor = .clear
//        }
        
        cell.defaultCell()
        cell.viewForClose.isHidden = true
        
//        cell.defaultCell(cups[indexPath[1]])
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("added")
        collectionView.cellForItem(at: selectedIndexPath)?.backgroundColor = .clear
        selectedIndexPath = indexPath
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .black
        database.child(Auth.auth().currentUser!.uid).child("defaultCup").setValue(cups[indexPath.row])
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
