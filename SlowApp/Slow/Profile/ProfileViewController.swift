//
//  ProfileViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 08.11.2021.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var profileImage : UIImage? = UIImage(named: "Rock")
    var level: Int = 0
    var numberOfCups : Int = 10
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let width  = (view.frame.width)
            switch indexPath[1] {
            case 0:
                return CGSize(width: width, height: width/1.5)
            case 1:
                return CGSize(width: width, height: width/3)
            case 2:
                return CGSize(width: width, height: width)
            case 3:
                return CGSize(width: width, height: width/3)
//            case 4:
//                print("Переменная равна 22")
            default:
                return CGSize(width: 100, height: width/1.5)
            }
                
            
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath[1] == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
            let width  = (view.frame.width)
            cell.profileImageView.layer.cornerRadius = width/1.5/2
            cell.profileImageView.layer.masksToBounds = false
            cell.profileImageView.clipsToBounds = true
    //        cell.backgroundColor = .white
            return cell
        } else if indexPath[1] == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelLabelCell", for: indexPath) as! LevelLabelCell
            cell.setText( text: "Уровень \(level) \n Это означает, что ваша максимальная серия недель — \(level)")
            
            return cell
        } else if indexPath[1] == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupsTableViewCell", for: indexPath) as! CupsTableViewCell
            
                
            return cell
        } else if indexPath[1] == 3 {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelLabelCell", for: indexPath) as! LevelLabelCell
            
            cell.setText( text: "Зачем пить воду?")
            cell.layoutIfNeeded()
    
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
            let width  = (view.frame.width)
            cell.profileImageView.layer.cornerRadius = width/1.5/2
            cell.profileImageView.layer.masksToBounds = false
            cell.profileImageView.clipsToBounds = true
    //        cell.backgroundColor = .white
            return cell
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath[1] == 3 {
            
            self.navigationController?.pushViewController(WhyNeedDrinkWaterController(), animated: true)
        }
        else {
            print(indexPath)
        }
    }
   
    
    let allItems: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = UIScreen.main.bounds.width
//        layout.itemSize = CGSize(width:width/2, height: width/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ProfileImageCell.self, forCellWithReuseIdentifier: "ProfileImageCell")
        collection.register(LevelLabelCell.self, forCellWithReuseIdentifier: "LevelLabelCell")
        collection.register(CupsTableViewCell.self, forCellWithReuseIdentifier: "CupsTableViewCell")
        
        collection.backgroundColor = .white
        return collection
        
    }()
    
    var profileName : String = "Скала Джонсон"
    let SummaryLabel : UILabel = {
        let label = UILabel()
//        label.text = profileName
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allItems.dataSource = self
        allItems.delegate = self
        allItems.isScrollEnabled = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 244, green: 244, blue: 244, alpha: 0.95))
        SummaryLabel.text = profileName
        self.navigationItem.titleView = SummaryLabel
        self.navigationController?.navigationBar.backgroundColor = .white
        view.addSubview(allItems)
        allItems.backgroundColor  = .blue
        let allItems_constraints =
        [ allItems.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          allItems.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
          allItems.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          allItems.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ]
        NSLayoutConstraint.activate(allItems_constraints)
        
    }




}

