//
//  loginViewController.swift
//  FuroIosFrameWork
//
//  Created by 임재현 on 2023/07/12.
//


import UIKit
import AuthenticationServices


open class LoginViewController: UIViewController {

    var stackView: UIStackView!
    
    let clientId = CLIEINT_ID
    let apiKey = PUBLIC_API_KEY
    
    
    
    public let iconImage:UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        iv.layer.cornerRadius = 100 / 2
        iv.backgroundColor = .blue
        iv.backgroundColor = .white
        //let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        //iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        //iv.image =
        return iv
        
    }()
    
    public let welcomeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "testfuro에 오신 것을\n환영합니다"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public let googleButton:UIButton = {
    let button = UIButton(type: .system)
        button.setTitle("Google로 시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        button.layer.cornerRadius = 16
        return button
    }()
    
    public let kakaoButton:UIButton = {
    let button = UIButton(type: .system)
        button.setTitle("Kakao로 시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        button.layer.cornerRadius = 16
        return button
    }()
   
    public let naverButton:UIButton = {
    let button = UIButton(type: .system)
        button.setTitle("naver로 시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.addTarget(self, action: #selector(naverButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        button.layer.cornerRadius = 16
        return button
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        return textField
    }()

    public lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        return textField
    }()

    public lazy var emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start with Email", for: .normal)
        button.addTarget(self, action: #selector(startWithEmail), for: .touchUpInside)
        button.backgroundColor = view.backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        return button
    }()

    public lazy var passwordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start with Password", for: .normal)
        button.addTarget(self, action: #selector(startWithPassword), for: .touchUpInside)
        button.backgroundColor = view.backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false  // This is important to use Auto Layout
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true  // Set the height here
        return button
    }()

    public lazy var magicLinkstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, emailButton, passwordButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
       
        stackView.spacing = 10
        return stackView
    }()

    

   
   open override func viewDidLoad() {
        super.viewDidLoad()

        
        configUI()
        view.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.9427255795)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    func configUI() {
        
        view.addSubview(iconImage)
     
        iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        //iconImage.centerX(inView: view)
        
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(welcomeLabel)
     
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 30).isActive = true
        
        let oAuthStacks = UIStackView(arrangedSubviews: [googleButton,kakaoButton,naverButton])
        oAuthStacks.axis = .vertical
        oAuthStacks.distribution = .fillEqually
        oAuthStacks.alignment = .fill
        oAuthStacks.spacing = 10
        
        view.addSubview(oAuthStacks)
       
        oAuthStacks.translatesAutoresizingMaskIntoConstraints = false
       
      
        
        NSLayoutConstraint.activate([
            oAuthStacks.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oAuthStacks.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            oAuthStacks.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
         
         
        ])
        
        let divider1 = UIView()
        divider1.backgroundColor = .lightGray
        view.addSubview(divider1)
        divider1.translatesAutoresizingMaskIntoConstraints = false
       
        


        divider1.topAnchor.constraint(equalTo: oAuthStacks.bottomAnchor, constant: 35).isActive = true
        divider1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40).isActive = true
            
        divider1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
       
        
        view.addSubview(magicLinkstackView)

        magicLinkstackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            magicLinkstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            magicLinkstackView.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 30),
            magicLinkstackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40)
         
        ])

        passwordTextField.isHidden = true
//
        
    }
    

    

    @objc func googleButtonTapped() {
       print("google")
   
        loginForGoogle()
        
    }
    
    @objc func kakaoButtonTapped() {
        print("kakao")
        
        loginForKaKao()

        
    }
    
    @objc func naverButtonTapped() {
        
        
       loginForNaver()

        
    }
    
    
    
    
    
    
    @objc func passwordStartButtonTapped() {

    }
    
    
    
    @objc func startWithEmail() {
        passwordTextField.isHidden = true
        passwordButton.backgroundColor = view.backgroundColor
        emailButton.backgroundColor = .red
        magicLinkstackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        magicLinkstackView.addArrangedSubview(emailTextField)
        magicLinkstackView.addArrangedSubview(emailButton)
        magicLinkstackView.addArrangedSubview(passwordButton)
        
   
        guard let email = emailTextField.text, !email.isEmpty else {
            // Handle the case where the text field is empty
            print("Email field is empty")
            return
        }
        
        
        if !isEmailValid(email) {
            // If email format is incorrect, show an alert
            let alert = UIAlertController(title: "Invalid Email", message: "Please enter a valid email address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        print("input : \(email)")
        

        createMagicLink(email: email) { success in
            if success {
                    print("Magic link created successfully!")
                    // Do your success-related tasks here
                } else {
                    print("Failed to create magic link.")
                    // Handle the failure here
                }
        }
        
        
        
    }

    @objc func startWithPassword() {
        passwordTextField.isHidden = false
        passwordButton.backgroundColor = .red
        emailButton.backgroundColor = view.backgroundColor
        magicLinkstackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        magicLinkstackView.addArrangedSubview(emailTextField)
        magicLinkstackView.addArrangedSubview(passwordTextField)
        magicLinkstackView.addArrangedSubview(passwordButton)
        magicLinkstackView.addArrangedSubview(emailButton)
        
        print("password 눌림")
        
        
        
        
        
        
        
    }
    
    
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func createMagicLink(email: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://api.furo.one/magic_links/email/login_or_create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        let authString = "\(CLIEINT_ID):\(PUBLIC_API_KEY)"
        let authData = authString.data(using: .utf8)!
        let authValue = "Basic \(authData.base64EncodedString())"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(false)  // Call the completion handler with `false` if there was an error
            } else if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
                completion(true)  // Call the completion handler with `true` if the request was successful
            } else {
                completion(false)  // Call the completion handler with `false` if no data was received
            }
        }
        task.resume()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    
}




