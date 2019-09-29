import UIKit

class FormTextField: UITextField {
    
    override func awakeFromNib() {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height, width: UIScreen.main.bounds.width, height: 1)
        bottomLine.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2.0)
        bottomLine.backgroundColor = Colors.lightTeal.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
}
