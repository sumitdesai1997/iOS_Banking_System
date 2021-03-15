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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickSignIn(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text{
            if email == "" || password == "" {
                openAlert(title: "Alert", message: "Email or Paasword can not be empty.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
            } else {
                if !email.validateEmail(){
                    openAlert(title: "Alert", message: "Please enter valid email.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                } else if !password.validatePass(){
                    openAlert(title: "Alert", message: "Please enter valid password.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                }
            }
        }
    }
    
}

