//
//  SignUpViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/25/1399 AP.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cPasswordTF: UITextField!
    @IBOutlet weak var questionTF: UITextField!
    
    var userList = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        
        vc.userList = userList
    }
    
    var alertTitle = ""
    var alertMessage = ""
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let name = nameTF.text, let email = emailTF.text, let password = passwordTF.text, let cPassword = cPasswordTF.text, let question = questionTF.text {
            if name == "" || email == "" || password == "" || cPassword == "" || question == "" {
                alertTitle = "Alert"
                alertMessage = "Please enter value for all fields."
                return false
            } else {
                if !name.validName(){
                    alertTitle = "Alert"
                    alertMessage = "Please enter valid name."
                    return false
                } else if !email.validateEmail(){
                    alertTitle = "Alert"
                    alertMessage = "Please enter valid email."
                    return false
                } else if !password.validatePass(){
                    alertTitle = "Alert"
                    alertMessage = "Please enter valid password."
                    return false
                } else if cPassword != password {
                    alertTitle = "Alert"
                    alertMessage = "Password and Confirm Password should be the exact match."
                    return false
                } else if !question.validName(){
                    alertTitle = "Alert"
                    alertMessage = "Please enter valid name for the dog."
                    return false
                }
    
                userList.append(User(name: name, email: email, password: password, question: question, balance: 70.0))
                return true
            }
        }
        return false
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        if shouldPerformSegue(withIdentifier: "SignUpToSignIn", sender: self){
            performSegue(withIdentifier: "SignUpToSignIn", sender: self)
        } else {
            openAlert(title: alertTitle, message: alertMessage, alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
        }
    }
    
    @IBAction func clickiSignIn(_ sender: Any) {
        let suvc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(suvc, animated: true)
    }
    
    func showToast(message: String){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2-75, y: self.view.frame.height-100, width: 150, height: 40))
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.gray
        toastLabel.textColor = UIColor.white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseInOut, animations: {toastLabel.alpha = 0.0}) { (isCompleted) in toastLabel.removeFromSuperview()}
    }
    
}

