import Foundation
import UIKit

struct Alerts {
    static func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Что-то пошло не так..", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить", style: .default))
        return alert
    }
    
    static func successAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Поздравляю!", message: "Вы успешно зарегистрировались.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        return alert
    }
}
