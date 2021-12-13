//
//  ConfigureController.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 13.11.2021.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol ButtonDelegate: AnyObject {
    func onButtonTap(sender: UIButton)
}

class ConfigureController: UIViewController {
    
    private let database = Database.database().reference()
    weak var delegate: ButtonDelegate?
    private let email: String
    private var cups: Int = 10
    private var waterVolume: Int = 2000
    public func setAllParameters (age: Int, sex: Bool, height: Float, weight : Float ){
        ageInput.textField.text = "\(age)"
        sexInput.sexSwitch.sexSwitch.isOn = sex
        heightInput.textField.text = "\(height)"
        weightInput.textField.text = "\(weight)"
    }
    @objc
    func goToMainViewController() {
        if let age = Int(ageInput.textField.text!),
            let height = Float(heightInput.textField.text!),
            let uid = Auth.auth().currentUser?.uid,
           let weight = Float(weightInput.textField.text!) {
        
            let sex = sexInput.sexSwitch.sexSwitch.isOn ? "Male" : "Female"
            database.child(uid).child("age").setValue(age)
            database.child(uid).child("sex").setValue(sex)
            database.child(uid).child("height").setValue(height)
            database.child(uid).child("weight").setValue(weight)
            database.child(uid).child("dailyWaterIntake").setValue(waterVolume)
            database.child(uid).child("cups").setValue(cups)
            
            
            
            
            database.child(uid).observe(.value, with: {snapshot in
                if !snapshot.hasChild("history") {
                    debugPrint("Empty History")
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "ddMMyyyy"
                    let date = dateFormatterPrint.string(from: Date())

                    self.database.child(uid).child("history").setValue( [date : 0] as NSDictionary)

                }
                if !snapshot.hasChild("defaultCup") {
                    self.database.child(uid).child("defaultCup").setValue("default")
                }

            })
            onButtonTap(sender: nextButton)
                
            
//            let newVc = MainViewController()
//            newVc.modalPresentationStyle = .overFullScreen
//            navigationController?.navigationItem.titleView = nil
//            navigationController?.setViewControllers([newVc], animated: true)
        }
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
        inp.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        inp.sexSwitch.sexSwitch.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.valueChanged)
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
        inp.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        inp.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return inp
    }()
    
    lazy var finalVol: finalWaterVolume = {
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
        
        
        finalVol.volumeLabel.text = ageInput.textField.text
        
        //keyboard hide
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [ageInput, sexInput, weightInput, heightInput])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        view.addSubview(finalVol)
        view.addSubview(nextButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 260),
            
            finalVol.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            finalVol.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            finalVol.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            finalVol.heightAnchor.constraint(equalToConstant: 172),
            nextButton.topAnchor.constraint(equalTo: finalVol.bottomAnchor, constant: 10),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        finalVol.layoutIfNeeded()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Подсчет воды и вывод в лейблы
    @objc func textFieldDidChange() {
        let age = (Double(ageInput.textField.text ?? "0") ?? 0) < 7 ? 50.0 : 30.0
        let sex = sexInput.sexSwitch.sexSwitch.isOn ? 1.1 : 1
        let weight = Double(weightInput.textField.text ?? "0") ?? 0
        let height = Double(heightInput.textField.text ?? "0") ?? 0
        let coefficient = (weight > 35 && height > 120) ? log(height / weight) : 1
        let volume = age * weight * coefficient * sex
        let glass = volume / 200
        waterVolume = Int(volume)
        cups = Int(glass)
        finalVol.volumeLabel.text = volume > 0 ? String(Int(volume)) + " мл" : "2000 мл"
        finalVol.glassLabel.text = glass > 0 ? String(Int(round(glass))) + " стаканов" : "10 стаканов"
        if weight > 200 { weightInput.textField.text = "200" }
        if height > 300 { heightInput.textField.text = "300" }
        if (Double(ageInput.textField.text ?? "0") ?? 0) > 120 { ageInput.textField.text = "120" }
    }
    func onButtonTap (sender: UIButton) {
        delegate?.onButtonTap(sender: sender)
    }
    
}




