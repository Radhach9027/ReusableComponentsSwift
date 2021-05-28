import UIKit

public enum AnimatedViewMessage {
    case message(String)
}

public enum Transform {
    case show
    case hide
}

@available(iOS 11.0, *)
public final class AnimatedView: UIView {
    
    private static var sharedInstance: AnimatedView?
    
    public class var shared : AnimatedView {
        guard let instance = self.sharedInstance else {
            let strongInstance = AnimatedView()
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
        
    private init() { super.init(frame: .zero)}
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}

    private static let actualHeight: CGFloat = 60
    
    private lazy var titleLabel: (UIColor, String) -> UILabel = { (textColor, title) in
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = title
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .cyan
        return scroll
    }()
    
    private lazy var viewHeight: (AnimatedViewMessage) -> CGFloat = { (message) in
        switch message {
            case let .message(message):
                let size = message.sizeOfString(string: message, constrainedToWidth: Double(UIScreen.main.bounds.size.width - AnimatedView.actualHeight))
                return size.height < AnimatedView.actualHeight ? AnimatedView.actualHeight : size.height + AnimatedView.actualHeight
        }
    }
    
    public func present(message: AnimatedViewMessage, postion: AnimatePosition, bgColor: UIColor, image: UIImage? = nil, controller: UIViewController) {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.show(hide: true)
        addConstrints(postion: postion, message: message, controller: controller)
    }
}

@available(iOS 11.0, *)
private extension AnimatedView {
    
    func addConstrints(postion: AnimatePosition, message: AnimatedViewMessage, controller: UIViewController) {
        defer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.transfrom(with: .show)
            }
        }
        
        guard let rootView = controller.view else { return }
        switch message {
            
            case let .message(text):
                let titleLabel: UILabel = self.titleLabel(.white, text)
                self.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(titleLabel)
                rootView.addSubview(self)
                
                switch postion {
                    case .top:
                        self.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: controller.navigationController?.isNavigationBarHidden == true ? 20: 60).isActive = true
                    case .bottom:
                        self.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor, constant: -(self.viewHeight(message) + (controller.tabBarController?.hidesBottomBarWhenPushed == true ? 0 : 5))).isActive = true
                    case .middle:
                        self.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: rootView.frame.size.height / 2 - self.viewHeight(message)).isActive = true
                }
                
                self.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 10).isActive = true
                self.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -10).isActive = true
                self.heightAnchor.constraint(equalToConstant: self.viewHeight(message)).isActive = true
                
                titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
                titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                titleLabel.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor).isActive = true
        }
    }
    
    func transfrom(with transform: Transform) {
        
        switch transform {
            case .show:
                show(hide: false)
                UIView.animate(withDuration: 0.8) { [weak self] in
                    self?.alpha = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                        self?.transfrom(with: .hide)
                    }
                }
            case .hide:
                UIView.animate(withDuration: 0.5,
                               animations: { [weak self] in
                                self?.alpha = 0
                               },completion: { [weak self] (true)  in
                                self?.removeFromSuperview()
                                AnimatedView.destroy()
                               })
        }
    }
    
    func show(hide: Bool) {
        self.isHidden = hide
        self.alpha = 0
    }
}
