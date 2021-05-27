import UIKit

public enum CustomPopupAnimateOptions {
    case affineIn
    case crossDisolve
    case affineOut
    case bounce
}

public final class CustomPopup: UIView, Nib {
    
    private var _window: UIWindow?
    public init(window: UIWindow) {
        super.init(frame: .zero)
        self.loadNibFile()
        self._window = window
        print("CustomPopup init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("CustomPopup de-init")
    }
    
    @IBOutlet weak var customPopView: CustomView!
    @IBOutlet weak var headerBgView: CustomImageView!
    @IBOutlet weak var headerCircularView: CustomView!
    @IBOutlet weak var headerCircularImageView: CustomImageView!
    @IBOutlet weak var dismissButton: CustomButton!
    @IBOutlet weak var messageLabel: UILabel!
    private var currentState: CustomPopupAnimateOptions = .affineIn
}

extension CustomPopup {

    private func loadNibFile() {
        registerNib()
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
    }
}
