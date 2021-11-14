//
//  ArticleCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    
    var imageArticle = UIImage(named: "Rock")
    var imageView = UIImageView()
    let headerLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = -1
//        label.layer.cornerRadius = 13
        label.clipsToBounds = true;
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label

    }()
    let linkLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = -1
//        label.layer.cornerRadius = 13
        label.clipsToBounds = true;
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 13
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        self.addSubview(headerLabel)
        self.addSubview(linkLabel)
        let imageView_constraints = [
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(imageView_constraints)
        
        let headerLabel_constraints = [
            headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: linkLabel.topAnchor),
            headerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(headerLabel_constraints)
        
        let linkLabel_constraints = [
            linkLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            linkLabel.heightAnchor.constraint(equalToConstant: 22),
            linkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            linkLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(linkLabel_constraints)
        
        
        
    }
    func setImage(image:UIImage?){
        imageView.image = image
    }
    func setTexts(link:String,header:String){
        linkLabel.text = link
        headerLabel.text = header
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Жопа какает
    */

}
