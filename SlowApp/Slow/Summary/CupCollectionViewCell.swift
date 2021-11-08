//
//  CupCollectionViewCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 05.11.2021.
//

import UIKit

class CupCollectionViewCell: UICollectionViewCell {
    
    let closeImage: UIImage? = {
        UIImage(named: "xmark.png")
    }()
    var closeFlag : Bool = false
    let closeImageView:UIView = {
        
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let closeImageView = UIImageView(image:  UIImage(named: "xmark.png"))
        closeImageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(closeImageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints =
        [   closeImageView.leftAnchor.constraint(equalTo: imageView.leftAnchor,constant: 6),
            closeImageView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -6),
            closeImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6),
            closeImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
        imageView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        
        return imageView
    }()
    let plusImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "+mark.png"))
        
        imageView.largeContentImageInsets = UIEdgeInsets(top: 10,
                                                         left: 10,
                                                         bottom: 10,
                                                         right: 10)
        return imageView
        
    }()
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
        let scaleOfCloseImageView = 25.0
        closeImageView.layer.cornerRadius = (scaleOfCloseImageView/2)
        let closeImageViewConstraints =
        [closeImageView.centerXAnchor.constraint(equalTo: image.rightAnchor),
         closeImageView.centerYAnchor.constraint(equalTo: image.topAnchor),
         closeImageView.heightAnchor.constraint(equalToConstant: scaleOfCloseImageView),
         closeImageView.widthAnchor.constraint(equalToConstant: scaleOfCloseImageView)
        ]
        NSLayoutConstraint.activate(closeImageViewConstraints)
    }

    func defaultCell(){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
