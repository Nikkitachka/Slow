//
//  ArticleCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    
    var imageArticle = UIImage(named: "Rock")
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2

        label.clipsToBounds = true;
        label.font = UIFont.systemFont(ofSize: 18)
//        label.textAlignment = .center
        return label

    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .darkGray
        label.clipsToBounds = true;
        label.font = UIFont.systemFont(ofSize: 14)
        return label

    }()
    let linkLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = -1
        label.textColor = .lightGray
        label.clipsToBounds = true;
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .left
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white

        self.addSubview(imageView)
        self.addSubview(headerLabel)
        self.addSubview(contentLabel)
        let imageView_constraints = [
            imageView.leftAnchor.constraint(equalTo: contentLabel.rightAnchor, constant: 6),
            imageView.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 4/3)
        ]
        NSLayoutConstraint.activate(imageView_constraints)
        let headerLabel_constraints = [
            headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
//            headerLabel.bottomAnchor.constraint(equalTo: linkLabel.topAnchor),
            headerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ]
        NSLayoutConstraint.activate(headerLabel_constraints)
        
        let contentLabel_constraints = [
            contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            contentLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
//            headerLabel.bottomAnchor.constraint(equalTo: linkLabel.topAnchor),
            contentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ]
        NSLayoutConstraint.activate(contentLabel_constraints)
//        let linkLabel_constraints = [
//            linkLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
//            linkLabel.heightAnchor.constraint(equalToConstant: 22),
//            linkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            linkLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
//        ]
//        NSLayoutConstraint.activate(linkLabel_constraints)
    }
    
    
    func setImage(image:UIImage?){
        
        imageView.image = image
    }
    func setTexts(link:String,header:String,content:String){
        linkLabel.text = " 🔗" + link
        headerLabel.text = "" + header
        contentLabel.text = content
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    

}
