//
//  CupCollectionViewCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 05.11.2021.
//

import UIKit

class CupCollectionViewCell: UICollectionViewCell {
    
    
    var closeFlag : Bool = false
    let closeImageView:UIImageView = {
        
        let imageView = UIImageView(image:  UIImage(named: "xmark.png"))
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    let plusImage = UIImage(named: "+mark.png")
    var image = UIImageView(image: UIImage(named: "defaultcup.png"))
    let back: UIView = {
        let back = UIView()
        back.backgroundColor = .yellow
        back.layer.cornerRadius = 13
        back.translatesAutoresizingMaskIntoConstraints = false
        let backConstraints =
        [back.heightAnchor.constraint(equalToConstant: 60),
         back.widthAnchor.constraint(equalToConstant: 60)
            ]
        NSLayoutConstraint.activate(backConstraints)
        return back
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(back)
        back.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        let imageConstraints =
        [   image.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 6),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        closeImageView.translatesAutoresizingMaskIntoConstraints = false
        back.addSubview(closeImageView)
        let closeImageViewConstraints =
        [closeImageView.centerXAnchor.constraint(equalTo: image.rightAnchor),
         closeImageView.centerYAnchor.constraint(equalTo: image.topAnchor),
         closeImageView.heightAnchor.constraint(equalToConstant: 20),
         closeImageView.widthAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(closeImageViewConstraints)
    }

    func defaultCell(){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
