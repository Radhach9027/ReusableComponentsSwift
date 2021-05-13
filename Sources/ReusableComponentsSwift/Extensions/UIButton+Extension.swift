import UIKit

extension UIButton {
    
    public func addBorder(side: UIButtonBorderSide = .Bottom, color: UIColor, width: CGFloat, content: String, contentFont: UIFont) {
        let border = CALayer()
        border.name = "BottomLine"
        border.backgroundColor = color.cgColor
        
        
        let stringWidth = content.widthOfString(usingFont: contentFont)
        
        switch side {
            case .Top:
                border.frame = CGRect(x: 0, y: 0, width: stringWidth, height: width)
            case .Bottom:
                border.frame = CGRect(x: 0, y: self.frame.size.height == 0 ? 40 - width : self.frame.size.height - width, width: stringWidth, height: width)
            case .Left:
                border.frame = CGRect(x: 0, y: 0, width: stringWidth, height: self.frame.size.height)
            case .Right:
                border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: stringWidth, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
    
    public func removeLayer(_ name: String = "BottomLine") {
        
        for innerLayer in self.layer.sublayers ?? [CALayer]() {
            if innerLayer.name == name {
                innerLayer.removeFromSuperlayer()
            }
        }
    }
}
