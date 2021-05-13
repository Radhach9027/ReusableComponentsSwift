import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
    
    func animate(newText: String, characterDelay: TimeInterval) {
        self.text = ""
        for (index, character) in newText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) { [weak self] in
                DispatchQueue.main.async {
                    self?.text?.append(character)
                }
            }
        }
    }
}
