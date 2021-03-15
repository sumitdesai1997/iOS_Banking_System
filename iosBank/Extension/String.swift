//
//  String.swift
//  iosBank
//
//  Created by Sumit Desai on 12/25/1399 AP.
//

import Foundation

extension String{
    
    func validateEmail() -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyReg(regexStr: emailReg)
    }
    
    func validatePass(mini: Int = 8, max: Int = 8) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        var passReg = ""
        if mini >= max{
            passReg = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        }else{
            passReg = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyReg(regexStr: passReg)
    }
    
    //https://stackoverflow.com/a/39284766/8201581
    
    func applyReg(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
