import UIKit

public struct AlertParameters {
    public var title: String?
    public var action: ((UIAlertAction) -> Void)?
    public var preferredAction: Bool
    public var actionStyle: UIAlertAction.Style
    
    public init(title: String, action: ((UIAlertAction) -> Void)? = nil, preferredAction: Bool = false, actionStyle: UIAlertAction.Style = .default) {
        self.title = title
        self.action = action
        self.preferredAction = preferredAction
        self.actionStyle = actionStyle
    }
}

public final class Alert {
    
    public class func presentAlert(withTitle title: String? = nil, message: String? = nil, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("You've pressed OK Button")
        }
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }

    public class func presentAlert(withTitle title: String? = nil, message: String? = nil, actionParameters: [AlertParameters], controller: UIViewController, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        if actionParameters.isEmpty {
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            for parameters in actionParameters {
                let actionStyle: UIAlertAction.Style = parameters.actionStyle
                let action = UIAlertAction(title: parameters.title, style: actionStyle, handler: parameters.action)
                alertController.addAction(action)
                if parameters.preferredAction {
                    alertController.preferredAction = action
                }
            }
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}
