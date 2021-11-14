//
//  LevelLabelCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 14.11.2021.
//

import UIKit

class LevelLabelCell: UICollectionViewCell {
    var text = ""
    
    
    let contentLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = -1
        label.layer.cornerRadius = 13
        label.clipsToBounds = true;
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        


        self.addSubview(contentLabel)
        let constraints =
        [

            contentLabel.topAnchor.constraint(equalTo: self.topAnchor),
            contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
         contentLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
         contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ]
        NSLayoutConstraint.activate(constraints)
    
    }
    func setText(text :String) {
        contentLabel.text = text
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
