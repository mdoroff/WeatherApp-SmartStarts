//
//  Login.swift
//  login
//
//  Created by Vargese, Sangeetha on 11/10/22.
//

import SwiftUI

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
        // swiftlint:disable line_length
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        // swiftlint:enable line_length
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func validateZip() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^\\d{5}(?:[-\\s]?\\d{4})?$")
            .evaluate(with: self)
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
            isValidEmail()
        }
    }
    @Published var error: String?
    
    func isValidEmail() {
        let emailRequired = ClosureValidationRule { !$0.isEmpty ? .success : .failed(reason: "Required")}
        
        let isValidEmail = ClosureValidationRule { _ in self.email.textFieldValidatorEmail() ? .success : .failed(reason: "Invalid Email")}
        
        let array = [emailRequired, isValidEmail]
        
        for condition in array {
            let result = condition.validate(text: email)
            switch result {
            case .failed(let reason):
                self.error = reason
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
        for condition in model {
            let result = condition.validate(text: password)
            switch result {
            case .failed(let reason):
                self.error = reason
                return
            default:
                self.error = nil
            }
        }
    }
}

@MainActor class ZipCodeValidationObject: ObservableObject {
    @Published var zipCode = "" {
        didSet {
            let filtered = zipCode.filter { $0.isNumber }
            if zipCode != filtered {
                zipCode = filtered
            }
            isValidZipCode()
        }
    }
    @Published var error: String?
    
    func isValidZipCode() {
        let zipCodeEmpty = ClosureValidationRule { !$0.isEmpty ? .success : .failed(reason: "Required")}
        let validFormat = ClosureValidationRule { _ in self.zipCode.validateZip() ? .success : .failed(reason: "Not a valid zipcode") }
        let zipLength = ClosureValidationRule { $0.count <= 5 ? .success : .failed(reason: "Must be less than 5 digits")}

        let array = [zipCodeEmpty, validFormat, zipLength]
        
        for condition in array {
            let result = condition.validate(text: zipCode)
            switch result {
            case .failed(let reason):
                self.error = reason
                return
            default:
                self.error = nil
            }
        }
    }
}

@MainActor class PhoneValidationObject: ObservableObject {
    @Published var phone = "" {
        didSet {
            let filtered = phone.filter { $0.isNumber }
            if phone != filtered {
                phone = filtered
            }
            isValidPhone()
        }
    }
    @Published var error: String?
    
    func isValidPhone() {
        let phoneEmpty = ClosureValidationRule { !$0.isEmpty ? .success : .failed(reason: "Required")}
        let phoneLength = ClosureValidationRule { $0.count <= 10 ? .success : .failed(reason: "Must be less than 10 digits")}
        
        let array = [phoneEmpty, phoneLength]
        
        for condition in array {
            let result = condition.validate(text: phone)
            switch result {
            case .failed(let reason):
                self.error = reason
                return
            default:
                self.error = nil
            }
        }
    }
}
