//
//  ProfileImageCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit

class ProfileImageCell: UICollectionViewCell {
    
    var profileImage = UIImage(named: "Rock")
    var profileImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        profileImageView.image = profileImage
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        self.addSubview(profileImageView)
        NSLayoutConstraint.activate(constraints)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
