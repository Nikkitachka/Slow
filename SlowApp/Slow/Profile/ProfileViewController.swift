//
//  ProfileViewController.swift
//  Slow
//
//  Created by Петр Ларочкин on 08.11.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        SummaryLabel.text = profileName

        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.view.backgroundColor = UIColor(cgColor:
                                        CGColor(srgbRed: 244, green: 244, blue: 244, alpha: 0.95))
        self.navigationItem.titleView = SummaryLabel
        self.navigationController?.navigationBar.backgroundColor = .white
        
            view.addSubview(scrollView)
            scrollView.addSubview(scrollViewContainer)
        
        
        
            scrollViewContainer.addArrangedSubview(redView)
            
        
        
        
        
        
        
            scrollViewContainer.addArrangedSubview(blueView)
            scrollViewContainer.addArrangedSubview(greenView)

        
        
        
        
        
        
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            // this is important for scrolling
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }

        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()

            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

        let scrollViewContainer: UIStackView = {
            let view = UIStackView()

            view.axis = .vertical
            view.spacing = 10

            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        let redView: UIView = {
            let view = UIView()
            
            let profileImageView : UIImageView = {
                let imageView = UIImageView()
                
                imageView.image = UIImage(named: "Rock.png")
                imageView.contentMode = .scaleAspectFill
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            
            view.addSubview(profileImageView)
            let constraint = [
                profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
                profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ]
            NSLayoutConstraint.activate(constraint)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 500).isActive = true
            view.backgroundColor = .red
            return view
        }()

        let blueView: UIView = {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 200).isActive = true
            view.backgroundColor = .blue
            return view
        }()

        let greenView: UIView = {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
            view.backgroundColor = .green
            return view
        }()
    
    
    var profileImage = UIImage(named: "Rock.png")
    var profileName = "Скала Джонсон"
    
    

    let SummaryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//
//
//    let availableCupsLabel : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Доступные стаканы"
//        label.numberOfLines = 3
//        label.layer.cornerRadius = 13
//        label.clipsToBounds = true;
//        label.font = .boldSystemFont(ofSize: 24)
//        label.textAlignment = .center
//
//        return label
//    }()
//
//    var SeriesText = "Текущая серия 72 дня\n Это рекорд 💪"
//
//    let ChampionLabel : UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 3
//        label.layer.cornerRadius = 13
//        label.clipsToBounds = true;
//        label.font = .boldSystemFont(ofSize: 24)
//        label.textAlignment = .center
//        return label
//    }()
//
//
//    let back: UIScrollView = {
//        let back = UIScrollView()
//        back.isScrollEnabled = true
//
//        back.backgroundColor = .yellow
//        back.translatesAutoresizingMaskIntoConstraints = false
//        return back
//
//    }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(back)
//        let back_constraints = [
//            back.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            back.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            back.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ]
//        NSLayoutConstraint.activate(back_constraints)
//
        
//
//
//
//
//
//        let sizeOfProfileImage = view.frame.width / 2
//        profileImageView.image = profileImage
//        profileImageView.clipsToBounds = true
//        profileImageView.layer.cornerRadius = sizeOfProfileImage/2
//        back.addSubview(profileImageView)
//        let profileImageView_constraints =
//        [profileImageView.centerXAnchor.constraint(equalTo: back.centerXAnchor),
//         profileImageView.topAnchor.constraint(equalTo: back.topAnchor,constant: 16),
//         profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
//         profileImageView.heightAnchor.constraint(equalToConstant: sizeOfProfileImage)
//        ]
//        NSLayoutConstraint.activate(profileImageView_constraints)
//        ChampionLabel.text = SeriesText
//        back.addSubview(ChampionLabel)
//        let ChampionLabel_constraints = [
//            ChampionLabel.leftAnchor.constraint(equalTo: back.safeAreaLayoutGuide.leftAnchor,constant: 16),
//            ChampionLabel.rightAnchor.constraint(equalTo: back.safeAreaLayoutGuide.rightAnchor,constant: -16),
//            ChampionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50),
//            ChampionLabel.heightAnchor.constraint(equalToConstant: 1000)
//        ]
//        NSLayoutConstraint.activate(ChampionLabel_constraints)
//
//
//
//
//
//
//
//    }
//

}
