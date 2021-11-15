//
//  ConfigureController.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 13.11.2021.
//

import UIKit

class ConfigureController: UIViewController {
    

    let ageInput: inputContainer = {
        let inp = inputContainer()
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        inp.sexSwitch.isHidden = true
        inp.translatesAutoresizingMaskIntoConstraints = false
        inp.label.text = "Возраст"
        inp.textField.attributedPlaceholder = NSAttributedString(
            string: "20",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        return inp
    }()
    
    let sexInput: inputContainer = {
        let inp = inputContainer()
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        inp.textField.isHidden = true
        inp.translatesAutoresizingMaskIntoConstraints = false
        inp.label.text = "Рост"
        inp.textField.attributedPlaceholder = NSAttributedString(
            string: "175",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        
        return inp
    }()
    
    let weightInput: inputContainer = {
        let inp = inputContainer()
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        inp.sexSwitch.isHidden = true
        inp.translatesAutoresizingMaskIntoConstraints = false
        inp.label.text = "Вес"
        inp.textField.attributedPlaceholder = NSAttributedString(
            string: "60",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        return inp
    }()
    
    let heightInput: inputContainer = {
        let inp = inputContainer()
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        inp.sexSwitch.isHidden = true
        inp.translatesAutoresizingMaskIntoConstraints = false
        inp.label.text = "Рост"
        inp.textField.attributedPlaceholder = NSAttributedString(
            string: "175",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        return inp
    }()
    
    let finalVol: finalWaterVolume = {
        let vol = finalWaterVolume()
        vol.translatesAutoresizingMaskIntoConstraints = false
        return vol
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
//        view.addSubview(ageInput)
//        view.addSubview(weightInput)
//        view.addSubview(heightInput)
        setupInputFields()
        
        
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [ageInput, sexInput, weightInput, heightInput])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 15
        
        view.addSubview(stackView)
        view.addSubview(finalVol)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 330),
            
            finalVol.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            finalVol.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            finalVol.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            finalVol.heightAnchor.constraint(equalToConstant: 200)
            ])
        finalVol.layoutIfNeeded()
    }
    
}




