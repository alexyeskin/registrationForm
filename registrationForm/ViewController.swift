import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    let moveValue: CGFloat = -150.0
    let moveBackValue: CGFloat = 0.0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizePlaceHolders()
        moveViewUp()
        moveViewDown()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func showPasswordButtonPressed(_ sender: Any) {
        self.passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let passwordTextFieldText = passwordTextField.text else { return }
        guard let emailTextFieldText = emailTextField.text else { return }
        let passwordText = Validation.shared.checkPasswordField(password: passwordTextFieldText)
        let emailText = Validation.shared.checkEmailField(email: emailTextFieldText)
        getStatus(emailStatus: emailText, passwordStatus: passwordText)
        
    }
    
    private func customizePlaceHolders() {
        modifyPlaceholder(Colors.lightTeal, "введите email", for: emailTextField)
        modifyPlaceholder(Colors.lightTeal, "введите пароль", for: passwordTextField)
    }
    
    private func modifyPlaceholder(_ placeholderColor: UIColor, _ placeholderText: String, for textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
    
    private func moveViewUp() {
        moveView(for: UIResponder.keyboardWillShowNotification, value: self.moveValue, state: true)
    }
    
    private func moveViewDown() {
        moveView(for: UIResponder.keyboardWillHideNotification, value: self.moveBackValue, state: false)
    }
    
    private func moveView(for name: NSNotification.Name?, value: CGFloat, state: Bool) {
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { (NC) in
            self.view.frame.origin.y = value
            UIView.transition(with: self.logoImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.logoImageView.isHidden = state
            }, completion: nil)
        }
    }
    
    func getStatus(emailStatus: Validation.correctionStatus, passwordStatus: Validation.correctionStatus) {
        switch emailStatus {
        case .errorExist(let error):
            print(error.rawValue)
            self.present(Alerts.errorAlert(message: error.rawValue), animated: true, completion: nil)
        case .noErrors:
            break
        }
        switch passwordStatus {
        case .noErrors:
            self.present(Alerts.successAlert(), animated: true, completion: nil)
        case .errorExist(let error):
            print(error.rawValue)
            self.present(Alerts.errorAlert(message: error.rawValue), animated: true, completion: nil)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordTextField.resignFirstResponder()
        default: break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case self.emailTextField:
            if string == "" && !Validation.shared.email.isEmpty {
                Validation.shared.email.removeLast()
            } else {
                Validation.shared.email.append(string)
            }
        case self.passwordTextField:
            if string == "" && !Validation.shared.password.isEmpty {
                Validation.shared.password.removeLast()
            } else {
                Validation.shared.password.append(string)
            }
        default: break
        }
        return true
    }
}
