//
//  Errors.swift
//  registrationForm
//
//  Created by  Юлия on 9/29/19.
//  Copyright © 2019 Alexandr. All rights reserved.
//

import Foundation

enum emailCorrectionStatus {
    case noErrors
    case errorExist(errors)
}

enum passwordCorrectionStatus {
    case noErrors
    case errorExist(errors)
}

enum errors: String {
    case atSignError = "Отсутствует обязательный символ '@' в поле email."
    case dotError = "Отсутствует обязательный символ '.' в поле email."
    case spaceError = "Присутствие пробела запрещено в поле email."
    case domainError = "Такого домена не существует."
    case emptyEmailError = "Поле email не должно быть пустым"
    case emptyPasswordError = "Поле пароля не должно быть пустым"
    case tooShortPasswordError = "Пароль слишком короткий, минимальное кол-во символов - 6"
    case tooLongPasswordError = "Пароль слишком длинный, максимальное кол-во символов - 36"
}
