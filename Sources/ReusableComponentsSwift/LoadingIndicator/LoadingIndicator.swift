import UIKit

public enum LoadingSteps {
    case start(animate: Bool)
    case end
    case success(animate: Bool, color: UIColor?)
    case failure(animate: Bool, color: UIColor?)
}

public enum AnimatePosition {
    case top, bottom, middle
}

public final class LoadingIndicator: UIView, Nib {
    
    private static var sharedInstance: LoadingIndicator?
    
    public class var shared : LoadingIndicator {
        
        guard let instance = self.sharedInstance else {
            let strongInstance = LoadingIndicator()
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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: CustomView!
    @IBOutlet weak var statusImageView: UIImageView!
    
    private var status: Bool = false
    private var title: String?
    private var duration: Double = 0.25
    public var _window: UIWindow?
    
    private init() {
        super.init(frame: .zero)
    }
    
    public func config(window: UIWindow) {
        self._window = window
        loadNibFile(window: window)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func loading(step: LoadingSteps, title: String? = "Loading...") {
        
        self.title = title
        switch step {
            case .start(let animated):
                startAnimating(animated: animated)
            case .end:
                stopAnimating()
            case let.success( animated, color):
                self.status = true
                self.statusImageView.image = UIImage(named: "check")
                success(animated: animated, color: color ?? .green)
            case let.failure( animated, color):
                self.status = true
                self.statusImageView.image = UIImage(named: "close")
                success(animated: animated, color: color ?? .systemRed)
                print("failure")
        }
    }
}


private extension LoadingIndicator {
    
    private func loadNibFile(window: UIWindow) {
        registerNib(window: window)
        self.statusImageView.image = self.statusImageView.image?.withRenderingMode(.alwaysTemplate)
        self.statusImageView.tintColor = .white
    }
    
    func startAnimating(animated: Bool) {
        guard let title = self.title else {return}
        if !status {
            animate(show: true)
            if  animated {
                self.titleLabel.animate(newText: title, characterDelay: duration)
                self.perform(#selector(runTimedCode), with: self, afterDelay: 10, inModes: [.common])
            } else {
                self.titleLabel.text = title
            }
        }
    }
    
    func stopAnimating() {
        self.titleLabel.text = ""
        self.spinner.stopAnimating()
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] (true)  in
            LoadingIndicator.destroy()
            self?.removeFromSuperview()
        }
    }
    
    func success(animated: Bool, color: UIColor) {
        animate(show: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.34) { [weak self] in
            UIView.animate(withDuration: 0.6, animations: { [weak self] in
                self?.loadingView.backgroundColor = color
                self?.loadingView.alpha = 1
                self?.statusImageView.alpha = 0.7
            }) { (true) in
                self?.statusImageView.alpha = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.stopAnimating()
                }
            }
        }
    }
    
    func animate(show: Bool) {
        DispatchQueue.main.async {
            if show {
                self.spinner.startAnimating()
                self.spinner.isHidden = false
                self.titleLabel.isHidden = false
            }else {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.titleLabel.isHidden = true
            }
        }
    }
    
    @objc func runTimedCode() {
        self.startAnimating(animated: true)
    }
}
