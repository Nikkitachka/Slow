//
//  WhyNeedDrinkWaterController.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit
import SafariServices

class WhyNeedDrinkWaterController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SFSafariViewControllerDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let width  = (view.frame.width)
            return CGSize(width: width, height: width/1.5)
            
                
            
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.setImage(image: UIImage(named: "Rock"))
        cell.setTexts(link: "Google.com", header: "GOLOFOFEL")
    
            return cell
        
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let safariViewController = SFSafariViewController(url: URL(string: "http://google.com")!)
                safariViewController.delegate = self
        
        // hide navigation bar and present safari view controller
//        navigationController?.isModalInPresentation = true
//        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(safariViewController, animated: true)
        
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
        collection.register(ArticleCell.self, forCellWithReuseIdentifier: "ArticleCell")

        collection.backgroundColor = .white
        return collection
        
    }()
    
    
    
    
    
    
    
    
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

        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 244, green: 244, blue: 244, alpha: 1))
        SummaryLabel.text = "articles"
        self.navigationItem.titleView = SummaryLabel
        
        self.navigationController?.navigationBar.backgroundColor = .white
        
        
        
        allItems.dataSource = self
        allItems.delegate = self
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
