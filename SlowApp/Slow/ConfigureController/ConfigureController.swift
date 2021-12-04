//
//  ConfigureController.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 13.11.2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ConfigureController: UIViewController {
    
    private var email : String
    private let database = Database.database().reference()
    
    
    @objc
    func goToMainViewController() {

        if let age = Int(ageInput.textField.text!), let height = Float(heightInput.textField.text!), let uid = Auth.auth().currentUser?.uid   {
            
            let dailyWaterIntake = 1500
            let sex = sexInput.sexSwitch.sexSwitch.isOn ? "Male" : "Female"
            database.child(uid).child("age").setValue(age)
            database.child(uid).child("sex").setValue(sex)
            database.child(uid).child("height").setValue(height)
            database.child(uid).child("dailyWaterIntake").setValue(dailyWaterIntake)
            let newVc = MainViewController()
            newVc.modalPresentationStyle = .overFullScreen

//            нужно что-то лучше
            UIApplication.shared.windows.first?.rootViewController = newVc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
             
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
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
        inp.label.text = "Пол"
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
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = UIColor(red: 168/255, green: 242/255, blue: 245/255, alpha: 1)
        button.layer.cornerRadius = 12
        if let titleLabel = button.titleLabel {titleLabel.font = UIFont.systemFont(ofSize: 24)}
        button.setTitleColor(UIColor(white: 0, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        return button
    }()
    
    init(_ currentEmail: String) {
        email = currentEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        
        setupInputFields()
        view.addSubview(nextButton)
        self.title = "Configure"
        
        //keyboard hide
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [ageInput, sexInput, weightInput, heightInput])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 15
        
        view.addSubview(stackView)
        view.addSubview(finalVol)
        view.addSubview(nextButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 330),
            
            finalVol.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            finalVol.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            finalVol.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            finalVol.heightAnchor.constraint(equalToConstant: 200),
            nextButton.topAnchor.constraint(equalTo: finalVol.bottomAnchor, constant: 12),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        finalVol.layoutIfNeeded()
    }
    
}




