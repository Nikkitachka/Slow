//
//  inputContainer.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 14.11.2021.
//

import UIKit

class inputContainer: UIView {
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.textAlignment = .center
        return tf
    }()
    
    var sexSwitch: sexView = {
        let sx = sexView()
        sx.translatesAutoresizingMaskIntoConstraints = false
        
        return sx
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
        self.layer.cornerRadius = 18
        self.backgroundColor = .white
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView(){
        
        self.addSubview(label)
        
        self.addSubview(textField)
        
        self.addSubview(sexSwitch)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 100),
            
            sexSwitch.widthAnchor.constraint(equalToConstant: 100),
            sexSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sexSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12)
        ])
    }
    
    
    
}
