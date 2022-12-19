//
//  Login.swift
//  login
//
//  Created by Vargese, Sangeetha on 11/10/22.
//

import SwiftUI
import os.log

protocol ValidationRule {
    // In our validation object, we check if the rule validated, if not we pull the "reason" out and assign it to our published error value
    // If all rules are valid then we set the error to nil / empty
    func validate(text: String) -> Validated
}

enum Validated {
    case success
    case failed(reason: String)
}

@MainActor class LoginViewModel: ObservableObject {
    @State var withValidationRules: [ValidationRule]
    @Published var emailObj = EmailValidationObject()
    @Published var passwordObj = PasswordValidationObject()
    @Published var zipCodeObj = ZipCodeValidationObject()
    @Published var phoneObj = PhoneValidationObject()
    
    init(withValidationRules: [ValidationRule]) {
        self.withValidationRules = withValidationRules
        passwordObj.model = withValidationRules
    }
}

extension String {
    func textFieldValidatorEmail() -> Bool {
        // Regex to check email text has correct email format.
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{6,255}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func validPassword() -> Bool {
        // Regex for checking for only numbers
        let numberRegEx  = ".*[0-9]+.*"
            let checkForNumber = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
            guard checkForNumber.evaluate(with: self) else { return false }

        // Regex for checking for special characters
            let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
            let checkForSpecialChar = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
            guard checkForSpecialChar.evaluate(with: self) else { return false }

            return true
    }
    
    func formatUSZipOrPhoneNumber(type: String) -> String {
        let initialValue = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = ""
        switch type {
        case "phone":
            mask = "(XXX)XXX-XXXX"
        default:
            mask = "XXXXX-XXXX"
        }
        var result = ""
        var startIndex = initialValue.startIndex
        let endIndex = initialValue.endIndex
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(initialValue[startIndex])
                startIndex = initialValue.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        return result
    }
}

struct ClosureValidationRule: ValidationRule {
    var validator: ((String) -> Validated)
    func validate(text: String) -> Validated {
        return validator(text)
    }
}

@MainActor class EmailValidationObject: ObservableObject {
    @Published var email = "" {
        didSet {
            // Limit charcter count for email to 255
            if email.count > 255 && oldValue.count <= 255 {
                email = oldValue
            }
            isValidEmail()
        }
    }
    @Published var error: String?
    
    func isValidEmail() {
        let isValidEmail = ClosureValidationRule { _ in self.email.textFieldValidatorEmail() ? .success : .failed(reason: "Must be valid a@b.co format")}
        
        let array = [isValidEmail]
        
        for condition in array {
            let result = condition.validate(text: email)
            switch result {
            case .failed(let reason):
                self.error = reason
                DLog(reason)
                return
            default:
                self.error = nil
            }
        }
    }
}

@MainActor class PasswordValidationObject: ObservableObject {
    @Published var password = "" {
        didSet {
            self.isValidPassword()
        }
    }
    var model = [ValidationRule]()
    @Published var error: String?
    
    private func isValidPassword() {
        let isValidPwd = ClosureValidationRule { _ in self.password.validPassword() ? .success : .failed(reason: "Must be at least 8 characters(a-Z with at least 1 number, 1 special character")}
        model.append(isValidPwd)
        
        for condition in model {
            let result = condition.validate(text: password)
            switch result {
            case .failed(let reason):
                self.error = reason
                ELog(reason)
                return
            default:
                self.error = nil
            }
        }
    }
}

struct ZipCodeValidationObject {
    var zipCode = "" {
        didSet {
            isValidZipCode()
        }
    }
    var error: String?
    
    mutating func isValidZipCode() {
        let numberRange = 6...9
        let zipLength = ClosureValidationRule { $0.count >= 5 && !numberRange.contains($0.count) ? .success : .failed(reason: "Must be valid 5 or 9 digits")}
        let array = [zipLength]
        
        for condition in array {
            let result = condition.validate(text: zipCode)
            switch result {
            case .failed(let reason):
                self.error = reason
                ILog(reason)
                return
            default:
                self.error = nil
            }
        }
    }
}

struct PhoneValidationObject {
     var phone = "" {
        didSet {
            // Restricting 0 and 1 as first digit in phonecnumber
            if phone.hasPrefix("0") || phone.hasPrefix("1") {
                phone.remove(at: phone.startIndex)
            }
            
            // Restricting 0 and 1 as fourth digit in phonecnumber
            if phone.count > 3, (phone[3] == "0" || phone[3] == "1") {
               let index = phone.index(phone.startIndex, offsetBy: 3)
               phone.remove(at: index)
            }
            isValidPhone()
        }
    }
    var error: String?
    mutating func isValidPhone() {
        let phoneLength = ClosureValidationRule { $0.count >= 13 ? .success : .failed(reason: "Must be valid (###) ###-#### format")}
        let array = [phoneLength]
        
        for condition in array {
            let result = condition.validate(text: phone)
            switch result {
            case .failed(let reason):
                error = reason
                ELog(reason)
                return
            default:
                error = nil
            }
        }
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
