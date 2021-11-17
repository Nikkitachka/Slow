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
        let closeImage = UIImage(named: "xmark.png")?.withAlignmentRectInsets(UIEdgeInsets(top: -2, left: -2, bottom: -2, right: -2))
        let imageView = UIImageView(image: closeImage)
        imageView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    let plusImage = UIImage(named: "+mark.png")?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
    
    var image = UIImageView(image: UIImage(named: "defaultcup.png"))
    let back: UIView = {
        let back = UIView()
        
        back.layer.cornerRadius = 13
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .yellow
        self.addSubview(back)
        let backConstraints =
        [back.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0),
         back.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         back.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         back.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ]

        NSLayoutConstraint.activate(backConstraints)
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
         closeImageView.heightAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/3),
         closeImageView.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/3)
        ]
        NSLayoutConstraint.activate(closeImageViewConstraints)
    }

    func defaultCell(){
        back.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
//        image.image = ( UIImage(named: "defaultcup.png"))
        
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "defaultcup.png")
        closeImageView.isHidden = false
    }
    func cellForAdd(){
        back.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        image.image = plusImage
        closeImageView.isHidden = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
