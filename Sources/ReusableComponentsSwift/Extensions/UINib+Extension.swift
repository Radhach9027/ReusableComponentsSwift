import UIKit

public protocol Nib {
    func registerNib(window: UIWindow)
}

extension Nib where Self : UIView {
    
    public func registerNib(window: UIWindow) {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return }
        guard let view = Bundle.module.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else { return }
            addSubview(view)
            window.addSubview(self)
            view.translatesAutoresizingMaskIntoConstraints = false
            self.translatesAutoresizingMaskIntoConstraints = false
            setConstraints(rootView: window, nibView: view)
    }
    
    func setConstraints(rootView: UIView, nibView: UIView) {
        self.leftAnchor.constraint(equalTo: rootView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: rootView.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
        
        nibView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        nibView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nibView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nibView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

