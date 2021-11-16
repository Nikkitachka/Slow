//
//  finalWaterVolume.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 14.11.2021.
//

import UIKit

class finalWaterVolume: UIView {
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша дневная норма воды"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let volumeLabel: UILabel = {
        let label = UILabel()
        label.text = "1500 ml"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let glassLabel: UILabel = {
        let label = UILabel()
        label.text = "6 стаканов"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
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
        
        self.addSubview(resultLabel)
        self.addSubview(volumeLabel)
        self.addSubview(glassLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            resultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            volumeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            volumeLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24),
            
            glassLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            glassLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 6)
        ])
    }
}
