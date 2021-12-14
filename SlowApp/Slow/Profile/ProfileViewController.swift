//
//  ProfileViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 08.11.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UICollectionViewDelegate, ButtonDelegate {
    
    private var database = Database.database().reference()
    private var indexPathOfSelected = IndexPath()
    var level: Int = 0
    var numberOfCups : Int = 10
    var defaultCup : String = "default"
    
    let cups = [
        "flat",
        "green",
        "h2o",
        "trubka",
        "classic",
        "glass",
        "glassalt",
        "wine",
        "winealt",
        "noire",
        "default",
        "bottle",
        "bottlealt",
        "bucket",
        "hotcup",
        "lovecup",
        "blood",
        "beer",
        "rose",
        "whiskey"
    ]
    
    @objc private func signOutButtonPressed (){
        try? Auth.auth().signOut()
        tabBarController?.tabBar.isHidden = true
        let authControllers = UINavigationController(rootViewController: SignUpController())
        tabBarController?.dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController = authControllers
//        authControllers.modalPresentationStyle = .overFullScreen
//        navigationController?.navigationItem.titleView = nil
//        navigationController?.setViewControllers([authControllers], animated: true)
    }
    @objc private func configureButtonPressed (){
        
        
        let user = database.child(Auth.auth().currentUser!.uid)
        if let email = Auth.auth().currentUser?.email {
            let vc = ConfigureController(email)
            user.observe(.value, with: {snapshot in

                if let userThings = snapshot.value as? [String : Any],
                   let sex = userThings["sex"] as? String,
                   let age = userThings["age"] as? Int,
                   let height = userThings["height"] as? Int,
                   let weight = userThings["weight"] as? Int
                        {
                    vc.setAllParameters(age: age, sex: sex == "Male", height: height, weight: weight)
                    vc.delegate = self
                }

            })
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    private var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        if let titleLabel = button.titleLabel {titleLabel.font = UIFont.systemFont(ofSize: 24)}
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var configureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Поправить измерения", for: .normal)
        button.backgroundColor = UIColor(red: 168/255, green: 242/255, blue: 245/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        if let titleLabel = button.titleLabel {titleLabel.font = UIFont.systemFont(ofSize: 24)}
        button.setTitleColor(UIColor(white: 0, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(configureButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 168/255, green: 242/255, blue: 245/255, alpha: 1)
        label.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        label.layer.borderWidth = 1
        return label
    }()
    private lazy var headingView : UILabel = {
        let label = UILabel()
        label.text = "Стаканы и уровень"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var allItems: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let width = 80
        layout.itemSize = CGSize(width:width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CupCollectionViewCell.self, forCellWithReuseIdentifier: "CupCollectionViewCell")
        collection.layer.cornerRadius = 13
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        return collection
    }()
    
    private func configureViews(){
        view.addSubview(headingView)
        let headingView_constraints = [
            headingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.heightOfHeadingView),
        ]
        NSLayoutConstraint.activate(headingView_constraints)
        
        view.addSubview(allItems)
        
        let allItems_constraints = [
            allItems.topAnchor.constraint(equalTo: headingView.bottomAnchor),
            allItems.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            allItems.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            allItems.heightAnchor.constraint(equalTo: allItems.widthAnchor)
        ]
        NSLayoutConstraint.activate(allItems_constraints)
        
        view.addSubview(signOutButton)
        let signOutButton_constraints = [
            signOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            signOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(signOutButton_constraints)
        
        view.addSubview(levelLabel)
        let levelLabel_constraints = [
            levelLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            levelLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            levelLabel.heightAnchor.constraint(equalToConstant: 150),
            levelLabel.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(levelLabel_constraints)
        
        
        view.addSubview(configureButton)
        let configureButton_constraints = [
            configureButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            configureButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            configureButton.heightAnchor.constraint(equalToConstant: 50),
            configureButton.bottomAnchor.constraint(equalTo: levelLabel.topAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(configureButton_constraints)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        let user = database.child(Auth.auth().currentUser!.uid)
        user.child("defaultCup").observe(.value, with: {snapshot in
            if let cupName = snapshot.value as? String,
               let item = self.cups.firstIndex(of: cupName) {
                self.defaultCup = cupName
                self.indexPathOfSelected = IndexPath(item: item, section: 0)
                self.configureViews()
            }
        })
        user.child("history").observe(.value, with: {snapshot in
            if let history = snapshot.value as? [String : Int] {
                self.level = history.count
                self.levelLabel.text = "Ваш уровень — \(self.level).\n Он означает количество дней, когда вы следили за выпитой водой."
            }
        })
    }
    
    func nextButtonTap(sender: UIButton) {
            self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCollectionViewCell", for: indexPath) as! CupCollectionViewCell
        cell.image.image = UIImage(named: cups[indexPath[1]])
        if indexPath == indexPathOfSelected {
            cell.selectCup()
        } else {
            cell.unSelectCup()
        }
        cell.defaultCell()
        cell.viewForClose.isHidden = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CupCollectionViewCell,
           let haveSelectedCell = collectionView.cellForItem(at: indexPathOfSelected) as? CupCollectionViewCell {
            let user = database.child(Auth.auth().currentUser!.uid)
            user.child("defaultCup").setValue(cups[indexPath.item] as String)
            haveSelectedCell.unSelectCup()
            indexPathOfSelected = indexPath
            cell.selectCup()
            
        }
    }
}


private extension ProfileViewController {
    struct Constants {
        static let heightOfHeadingView: CGFloat = 50
        static let heightOfwaterProgressBar: CGFloat = 5
        static let heightOfCurrentCupsLabel: CGFloat = 50
        static let heightOfGlassChecker: CGFloat = 90
        static let defaultSideInsets: CGFloat = 12
        static let defaultCornerRadius: CGFloat = 12
        static let defaultCupCellSize: CGFloat = 80
    }
}
