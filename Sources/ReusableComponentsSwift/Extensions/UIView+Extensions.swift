import UIKit

extension UIView {
    
    func dismiss(animate: CustomPopupAnimateOptions) {
        
        switch animate {
            case .affineIn:
                dismissTransfromAffine(view: self)
            case .crossDisolve:
                dismissCrossDisolve(view: self)
            case .affineOut:
                dismissTransfromAffineOut(view: self)
            case .bounce:
                dismissTransformBounce(view: self)
        }
    }
    
    func animate(animate: CustomPopupAnimateOptions) {
        
        switch animate {
            case .affineIn:
                transfromToAffine(view: self)
            case .crossDisolve:
                transfromToCrossDisolve(view: self)
            case .affineOut:
                transfromToAffineOut(view: self)
            case .bounce:
                transformToBounce(view: self)
        }
    }
    
    func transfromToAffine(view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            view.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 1
                view.transform = .identity
            })
        }
    }
    
    func transfromToAffineOut(view: UIView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            UIView.animate(withDuration: 0.5, animations: {
                view.transform = .identity
            })
        }
    }
    
    func transfromToCrossDisolve(view: UIView) {
        UIView.transition(with: view, duration: 1.5, options: .transitionCrossDissolve, animations: {
            view.alpha = 1
        }, completion: nil)
    }
    
    func transformToBounce(view: UIView) {
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       usingSpringWithDamping: 2.0,
                       initialSpringVelocity: 2.0,
                       options: [],
                       animations: {
                        view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        view.alpha = 1
                       }, completion: {
                        (value: Bool) in
                        UIView.transition(with: view, duration: 0.2, options: .curveEaseOut, animations: {
                                            view.transform = .identity }) })
    }
    
    func dismissTransfromAffineOut(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.2, options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    func dismissTransfromAffine(view: UIView) {
        view.alpha = 0
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.2, options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    func dismissCrossDisolve(view: UIView) {
        UIView.transition(with: view, duration:1.5, options: .transitionCrossDissolve, animations: {
        }){ (true) in
            self.removeFromSuperview()
        }
    }
    
    func dismissTransformBounce(view: UIView) {
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       usingSpringWithDamping: 2.0,
                       initialSpringVelocity: 2.0,
                       options: [],
                       animations: {
                        view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                       }, completion: {
                        (value: Bool) in
                        view.transform = .identity
                        UIView.transition(with: view, duration: 0.2, options: .curveEaseOut, animations: {
                                            self.removeFromSuperview() }) })
    }
}

