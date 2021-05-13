import UIKit

public enum CustomPopupAnimateOptions {
    case affineIn
    case crossDisolve
    case affineOut
    case bounce
}

public final class CustomPopup: UIView, Nib {
    
    private static var sharedInstance: CustomPopup?
    
    public class var shared : CustomPopup {
        guard let instance = self.sharedInstance else {
            let strongInstance = CustomPopup()
            self.sharedInstance = strongInstance
            return strongInstance
        }
        return instance
    }
    
    class func destroy() {
        DispatchQueue.main.async() {
            sharedInstance = nil
        }
    }
    
    private init() {
        super.init(frame: .zero)
        print("CustomPopup init")
    }
    
    public func config(window: UIWindow) {
        loadNibFile(window: window)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        CustomPopup.destroy()
        print("CustomPopup de-init")
    }
    
    @IBOutlet weak var customPopView: CustomView!
    @IBOutlet weak var headerBgView: CustomImageView!
    @IBOutlet weak var headerCircularView: CustomView!
    @IBOutlet weak var headerCircularImageView: CustomImageView!
    @IBOutlet weak var dismissButton: CustomButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    private var currentState: CustomPopupAnimateOptions = .affineIn
}

extension CustomPopup {

    private func loadNibFile(window: UIWindow) {
        registerNib(window: window)
        headerBgView.clipsToBounds = true
        headerBgView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
        headerBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }

    public func present(message: String, animate: CustomPopupAnimateOptions) {
        self.messageLabel.text = message
        self.currentState = animate
        self.customPopView.animate(animate: animate)
    }
}

private extension CustomPopup {
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animate: currentState)
        CustomPopup.destroy()
    }
}
