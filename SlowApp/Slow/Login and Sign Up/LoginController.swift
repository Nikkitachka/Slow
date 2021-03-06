//
//  LoginControl.swift
//  loginScreen
//
//  Created by Игорь Багдасарян on 03.11.2021.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func goToMainViewController() {
        //self.navigationController?.dismiss(animated: true)
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            debugPrint(email)
            debugPrint(password)
            if email.contains("@") && password.count >= 6 {
                
                Auth.auth().signIn(withEmail: email, password: password, completion: {
                    (user: AuthDataResult?, error: Error?) in
                        if let err = error {
                            debugPrint("Failed to create user \(err)")
                            return
                        } else {
                            debugPrint("Successfully get user: \(String(describing: user?.user.uid ?? "" ))")
                            let newVc = MainViewController()
                            newVc.modalPresentationStyle = .overFullScreen
                            self.navigationController?.navigationItem.titleView = nil
                            self.navigationController?.setViewControllers([newVc], animated: true)
//                            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        }
                    
                    
                })
            }
        }
        
    }
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .custom)
        let imageLogo = UIImage(named: "tg_image_592672127.jpeg")
        
        button.setImage(imageLogo, for: .normal)
        button.layer.cornerRadius = (imageLogo?.size.width ?? 175) / 2
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.cornerRadius = (imageLogo?.size.width ?? 175) / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.keyboardType = .emailAddress
        tf.textAlignment = .center
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.attributedPlaceholder = NSAttributedString(
            string: "почта@почта.ру",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.textAlignment = .center
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(
            string: "пароль",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = UIColor(red: 168/255, green: 242/255, blue: 245/255, alpha: 1)
        button.layer.cornerRadius = 12
        if let titleLabel = button.titleLabel {titleLabel.font = UIFont.systemFont(ofSize: 24)}
        button.setTitleColor(UIColor(white: 0, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(white: 0, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        return button
    }()
    
    
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.backBarButtonItem =
        
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        view.addSubview(plusPhotoButton)
        NSLayoutConstraint.activate([
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 175),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 175),
            plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
        ])
        
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 56),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        ])
        
        setupInputFields()
        
        //keyboard hide
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 15
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 60),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
            ])

    }
}
