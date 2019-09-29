//
//  Validation.swift
//  registrationForm
//
//  Created by  Юлия on 9/29/19.
//  Copyright © 2019 Alexandr. All rights reserved.
//

import Foundation

class Validation {
    static let shared = Validation()
    var email: String = ""
    var password: String = ""
    
    enum correctionStatus {
        case noErrors
        case errorExist(errors)
    }

    enum errors: String {
        case atSignError = "Отсутствует обязательный символ '@' в поле email."
        case dotError = "Отсутствует обязательный символ '.' в поле email."
        case spaceError = "Присутствие пробела запрещено в поле email."
        case formatError = "Формат email не корректен."
        case emptyEmailError = "Поле email не должно быть пустым"
        case emptyPasswordError = "Поле пароля не должно быть пустым"
        case tooShortPasswordError = "Пароль слишком короткий, минимальное кол-во символов - 6"
        case tooLongPasswordError = "Пароль слишком длинный, максимальное кол-во символов - 36"
    }

    
    func checkPasswordField(password: String) -> correctionStatus {
        switch password.count {
        case 0:
            return correctionStatus.errorExist(errors.emptyPasswordError)
        case 1...5:
            return correctionStatus.errorExist(errors.tooShortPasswordError)
        case 36...:
        return correctionStatus.errorExist(errors.tooLongPasswordError)
        default:
            return correctionStatus.noErrors
        }
    }
    
    func checkEmailField(email: String) -> correctionStatus {
        if !email.contains("@") {
            return correctionStatus.errorExist(errors.atSignError)
        } else if !email.contains(".") {
            return correctionStatus.errorExist(errors.dotError)
        } else if email.contains(" ") {
            return correctionStatus.errorExist(errors.spaceError)
        } else if email.isEmpty {
            return correctionStatus.errorExist(errors.emptyEmailError)
        } else if isValidEmail(email: email) == false {
            return correctionStatus.errorExist(errors.formatError)
        } else {
             return correctionStatus.noErrors
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
