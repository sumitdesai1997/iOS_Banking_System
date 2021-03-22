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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userList.append(User(name: "Sumit", email: "sumit123@gmail.com", password: "12345678q", question: "buzzo", balance: 70.0))
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
                    alertMessage = "Please enter minimum 8 digit password with 1 digit and 1 character."
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
    
    @IBAction func clickCreateAccount(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        present(vc, animated: true)
    }
    
    func showToast(message: String){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2-110, y: self.view.frame.height-100, width: 250, height: 40))
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

