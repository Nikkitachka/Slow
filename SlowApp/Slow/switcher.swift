//
//  switcher.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 14.11.2021.
//

import UIKit

class sexView: UIView {
    var sexSwitch: UISwitch = {
        let swtch = UISwitch()
        swtch.translatesAutoresizingMaskIntoConstraints = false
        
        return swtch
    }()
    
    let mLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "М"
        return label
    }()
    
    let fLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ж"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        
        self.addSubview(fLabel)
        self.addSubview(sexSwitch)
        self.addSubview(mLabel)
        
        NSLayoutConstraint.activate([
            fLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            fLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            sexSwitch.leftAnchor.constraint(equalTo: fLabel.rightAnchor, constant: 4),
            sexSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            mLabel.leftAnchor.constraint(equalTo: sexSwitch.rightAnchor, constant: 4),
            mLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

