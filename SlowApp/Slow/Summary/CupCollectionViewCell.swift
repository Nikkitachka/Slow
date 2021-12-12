//
//  CupCollectionViewCell.swift
//  Slow
//
//  Created by Петр Ларочкин on 01.11.2021.
//
import UIKit

class CupCollectionViewCell: UICollectionViewCell {
    
    
    var closeFlag : Bool = false
    
    
    var closeImageView : UIImageView = {
        let closeImage = UIImage(named: "xmark.png")
        let imageView = UIImageView(image: closeImage)
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        
        return imageView
    }()
    lazy var viewForSelected : UIView = {
        let close = UIView()
        let closeImage = UIImage(systemName:  "checkmark.seal.fill")
        let imageView = UIImageView(image: closeImage)
        imageView.contentMode = .scaleAspectFit
        close.addSubview(imageView)
//        close.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        close.layer.cornerRadius = 10
        close.translatesAutoresizingMaskIntoConstraints = false
        let imageView_constraints = [
            imageView.centerXAnchor.constraint(equalTo: close.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: close.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: close.heightAnchor),
            imageView.leftAnchor.constraint(equalTo: close.leftAnchor, constant: 5),
        ]
        NSLayoutConstraint.activate(imageView_constraints)
        return close
    }()
    var plusImage = UIImageView(image: UIImage(named: "+mark.png")?.withAlignmentRectInsets( UIEdgeInsets(top: -16, left: -16, bottom: -16, right: -16)))
    var defaultCup = UIImage(named: "defaultcup.png")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    var image = UIImageView()
    
    let back: UIView = {
        let back = UIView()
        
        back.layer.cornerRadius = 13
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    var viewForClose : UIView = {
        let close = UIView()
        close.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        close.layer.cornerRadius = 10
        close.translatesAutoresizingMaskIntoConstraints = false
        return close
    }()
    func setImageByName (_ name : String){
        
    }
    func selectCup(){
        viewForSelected.isHidden = false
        
    }
    func unSelectCup(){
        viewForSelected.isHidden = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image.image = defaultCup
        unSelectCup()
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
        back.addSubview(plusImage)
        plusImage.translatesAutoresizingMaskIntoConstraints = false
        let plusImageConstraints =
        [   plusImage.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 6),
            plusImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            plusImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            plusImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ]

        NSLayoutConstraint.activate(plusImageConstraints)
        closeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewForClose)
        viewForClose.addSubview(closeImageView)
        let closeImageView_constraints = [
            closeImageView.centerXAnchor.constraint(equalTo: viewForClose.centerXAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: viewForClose.centerYAnchor),
            closeImageView.widthAnchor.constraint(equalTo: closeImageView.heightAnchor),
            closeImageView.leftAnchor.constraint(equalTo: viewForClose.leftAnchor, constant: 5),
        ]
        NSLayoutConstraint.activate(closeImageView_constraints)
        
        let viewForCloseConstraints =
        [viewForClose.centerXAnchor.constraint(equalTo: image.rightAnchor),
         viewForClose.centerYAnchor.constraint(equalTo: image.topAnchor),
         viewForClose.heightAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/3),
         viewForClose.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/3)
        ]
        NSLayoutConstraint.activate(viewForCloseConstraints)
        
        self.addSubview(viewForSelected)
        let viewForSelectedConstraints =
        [viewForSelected.centerXAnchor.constraint(equalTo: image.rightAnchor),
         viewForSelected.centerYAnchor.constraint(equalTo: image.bottomAnchor),
         viewForSelected.heightAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/3),
         viewForSelected.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1/3)
        ]
        NSLayoutConstraint.activate(viewForSelectedConstraints)
        
    }

    func defaultCell(){

        plusImage.isHidden = true
        image.isHidden = false
        back.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        viewForClose.isHidden = false
        
    }
    func cellForAdd(){
        plusImage.isHidden = false
        image.isHidden = true
        viewForClose.isHidden = true
        back.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
