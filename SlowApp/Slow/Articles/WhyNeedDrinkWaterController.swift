//
//  WhyNeedDrinkWaterController.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit
import SafariServices

class WhyNeedDrinkWaterController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SFSafariViewControllerDelegate {
    
    let articles = articlesList
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let width  = (view.frame.width)
            return CGSize(width: width, height: width/2.3)
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath[1]
        let element = articles[index]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.setImage(image: element.2)
        cell.setTexts(link: element.0, header: element.1, content: element.4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath[1]
        let element = articles[index]
        let safariViewController = SFSafariViewController(url: URL(string: element.3)!)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true, completion: {})
        
    }
   
    
    let allItems: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = UIScreen.main.bounds.width
//        layout.itemSize = CGSize(width:width/2, height: width/2)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ArticleCell.self, forCellWithReuseIdentifier: "ArticleCell")

//        collection.backgroundColor = .white
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
        self.view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 244, green: 244, blue: 244, alpha: 0.95))
        SummaryLabel.text = "Зачем пить воду"
        self.navigationItem.titleView = SummaryLabel
        
        if #available(iOS 13, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
                navigationController?.navigationBar.standardAppearance = appearance;
                navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            }
        
        
        allItems.dataSource = self
        allItems.delegate = self
        view.addSubview(allItems)
        allItems.backgroundColor  = .clear
        let allItems_constraints =
        [ allItems.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          allItems.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
          allItems.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          allItems.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ]
        NSLayoutConstraint.activate(allItems_constraints)
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        // MARK: - TODO!!![[
        
    }
}
