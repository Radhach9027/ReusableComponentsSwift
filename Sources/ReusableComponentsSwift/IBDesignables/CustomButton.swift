import UIKit

@IBDesignable
class CustomButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var iPhone4s: CGFloat = 0.0 {
        didSet { deviceFont(.i3_5Inch,value:iPhone4s) }
    }
    
    @IBInspectable var iPhoneSE: CGFloat = 0.0 {
        didSet { deviceFont(.i4Inch,value:iPhoneSE) }
    }
    
    @IBInspectable var iPhone8: CGFloat = 0.0 {
        didSet { deviceFont(.i4_7Inch,value:iPhone8) }
    }
    
    @IBInspectable var iPhone8Plus: CGFloat = 0.0 {
        didSet { deviceFont(.i5_5Inch,value:iPhone8Plus) }
    }
    
    @IBInspectable var iPhone11Pro: CGFloat = 0.0 {
        didSet { deviceFont(.i5_8Inch,value:iPhone11Pro) }
    }
    
    @IBInspectable var iPhone11: CGFloat = 0.0 {
        didSet { deviceFont(.i6_1Inch,value:iPhone11) }
    }
    
    @IBInspectable var iPhone11Max: CGFloat = 0.0 {
        didSet { deviceFont(.i6_5Inch,value:iPhone11Max) }
    }
    
    @IBInspectable var iPadMini: CGFloat = 0.0 {
        didSet { deviceFont(.i7_9Inch,value:iPadMini) }
    }
    
    @IBInspectable var iPadPro9_7: CGFloat = 0.0 {
        didSet { deviceFont(.i9_7Inch,value:iPadPro9_7) }
    }
    
    @IBInspectable var iPadPro10_5: CGFloat = 0.0 {
        didSet { deviceFont(.i10_5Inch,value:iPadPro10_5) }
    }
    
    @IBInspectable var iPadPro12_9: CGFloat = 0.0 {
        didSet { deviceFont(.i12_9Inch,value:iPadPro12_9) }
    }

    open func deviceFont(_ device: UIDeviceSize,value:CGFloat) {
        if deviceSize == device {
            if let font = titleLabel?.font {
                titleLabel?.font = UIFont(descriptor: font.fontDescriptor, size: value)
                layoutIfNeeded()
            }
        }
    }
}
