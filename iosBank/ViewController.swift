//
//  ViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/24/1399 AP.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var userList = [User]()
    var user = User(name: "test", email: "test123@gmail.com", password: "12345678q", question: "buzzo", balance: 70.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userList.append(User(name: "test", email: "test123@gmail.com", password: "12345678q", question: "buzzo", balance: 70.0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sbvc = segue.destination as! SearchBusViewController
        
        for user in userList{
            if user.email == emailTF.text!{
                sbvc.user = user
            }
        }
    }
    
    var alertTitle = ""
    var alertMessage = ""
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let email = emailTF.text, let password = passwordTF.text{
            if email == "" || password == "" {
                alertTitle = "Alert"
                alertMessage = "Email or Paasword can not be empty."
                return false
            } else {
                if !email.validateEmail(){
                    alertTitle = "Alert"
                    alertMessage = "Please enter valid email."
                    return false
                } else if !password.validatePass(){
                    alertTitle = "Alert"
                    alertMessage = "Please enter valid password."
                    return false
                }
                
                for user in userList{
                    if user.email == email && user.password == password{
                        return true
                    }
                }
                alertTitle = "Alert"
                alertMessage = "User does not exist"
                return false
            }
        }
        return false
    }

    @IBAction func clickSignIn(_ sender: Any) {
        if shouldPerformSegue(withIdentifier: "SignInToSearchBus", sender: self){
            performSegue(withIdentifier: "SignInToSearchBus", sender: self)
        } else {
            openAlert(title: alertTitle, message: alertMessage, alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
        }
    }
    
    
}

