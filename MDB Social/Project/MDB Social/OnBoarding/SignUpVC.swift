//
//  SignUpVC.swift
//  MDB Social
//
//  Created by Evelyn Hu on 11/4/21.
//

import UIKit
import NotificationBannerSwift

class SignUpVC: UIViewController {
    
    
    private let signUpStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fullNameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Full Name:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let newEmailTextField: AuthTextField = {
        let tf = AuthTextField(title: "Email:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let usernameTextField: AuthTextField = {
        let tf = AuthTextField(title: "Username:")
      
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let newPasswordTextField: AuthTextField = {
        let tf = AuthTextField(title: "Password:")
        tf.textField.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let confirmPasswordTextField: AuthTextField = {
        let tf = AuthTextField(title: "Confirm Password:")
        tf.textField.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let signUpButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.primary.cgColor
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Error"
        lbl.textColor = .red
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
    
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)

   

    override func viewDidLoad() {
        
 
        super.viewDidLoad()
        view.backgroundColor = .white

        
        
        view.addSubview(signUpStack)
        
        signUpStack.addArrangedSubview(fullNameTextField)
        signUpStack.addArrangedSubview(newEmailTextField)
        signUpStack.addArrangedSubview(usernameTextField)
        signUpStack.addArrangedSubview(newPasswordTextField)
        signUpStack.addArrangedSubview(confirmPasswordTextField)
        signUpStack.addArrangedSubview(signUpButton)
        signUpStack.addArrangedSubview(errorLabel)
        
        signUpButton.layer.cornerRadius = 10
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)

        errorLabel.alpha = 0
        
        NSLayoutConstraint.activate([
            signUpStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: contentEdgeInset.left),
            signUpStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -contentEdgeInset.right),
            
            signUpStack.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: contentEdgeInset.top),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
           
        ])

        // Do any additional setup after loading the view.
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    //change this code, but replicate design of the signInButton
    @objc private func didTapSignUp(_ sender: UIButton) {
        
        let error = checkFields()
        
        if error != nil{
            
            showError(error!)
        }
        else{
            
            errorLabel.alpha = 0
            
            let fullName = fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = newEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = newPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userName = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            //this will check if the password is weak,
            SOCAuthManager.shared.signUp(withEmail: email, userName: userName, password: password, fullName: fullName) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
               
                    case .failure(let error):
                        switch error {
                        case .emailAlreadyInUse:
                            self.showErrorBanner(withTitle: "Email already in use", subtitle: "Please check your email address")
                        case .weakPassword:
                            self.showErrorBanner(withTitle: "Weak password", subtitle: "Please make it stronger")
                        case .internalError:
                            self.showErrorBanner(withTitle: "Internal error", subtitle: "")
                        default:
                            self.showErrorBanner(withTitle: "Unspecified error", subtitle: "")
                             
                        }
                    
                    case .success:
                    
                        
                        guard let window = self.view.window else { return }
                        window.rootViewController = FeedVC()
                    
                        let options: UIView.AnimationOptions = .transitionCrossDissolve
                        let duration: TimeInterval = 0.3
                        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
                }
                
                
            }

            
        }


    }
    
    private func showErrorBanner(withTitle title: String, subtitle: String? = nil) {
        showBanner(withStyle: .warning, title: title, subtitle: subtitle)
    }
    
    private func showBanner(withStyle style: BannerStyle, title: String, subtitle: String?) {
        guard bannerQueue.numberOfBanners == 0 else { return }
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle,
                                                titleFont: .systemFont(ofSize: 17, weight: .medium),
                                                subtitleFont: .systemFont(ofSize: 14, weight: .regular),
                                                style: style)
        
        banner.show(bannerPosition: .top,
                    queue: bannerQueue,
                    edgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15),
                    cornerRadius: 10,
                    shadowColor: .primaryText,
                    shadowOpacity: 0.3,
                    shadowBlurRadius: 10)
    }
    
    //add in the check to make sure both passwords match
    func checkFields() -> String? {
        
        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            newEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        if newPasswordTextField.text != confirmPasswordTextField.text{
            
            return "Your passwords do not match"
            
        }

        
        return nil
        
    }

}
