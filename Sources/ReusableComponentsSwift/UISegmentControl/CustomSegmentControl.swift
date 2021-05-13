import UIKit

public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

public struct CustomSegmentAttributes {
    
    public var itemMinSpacing: CGFloat
    public var itemSelectedColor: UIColor
    public var itemDefaultColor: UIColor
    public var itemTitleDefaultColor: UIColor
    public var itemTitleSelectedColor: UIColor
    public var segmentBgColor: UIColor
    public var segmentBorderColor: UIColor
    public var itemDefaultFont: UIFont
    public var itemSelectedFont: UIFont
    public var itemCornerRadius: CGFloat
    public var itemTextAlignment: UIControl.ContentHorizontalAlignment
    
    
    public init(itemMinSpacing: CGFloat = 10.0, itemSelectedColor: UIColor = .white, itemDefaultColor: UIColor = .white, itemTitleDefaultColor: UIColor = .black, itemTitleSelectedColor: UIColor  = .black, segmentBgColor: UIColor = .white, segmentBorderColor: UIColor = .gray, itemDefaultFont: UIFont = .systemFont(ofSize: 12), itemSelectedFont: UIFont = .systemFont(ofSize: 12), itemCornerRadius: CGFloat = 5.0, itemTextAlignment: UIControl.ContentHorizontalAlignment = .left) {
        
        self.itemMinSpacing = itemMinSpacing
        self.itemSelectedColor =  itemSelectedColor
        self.itemDefaultColor =  itemDefaultColor
        self.itemTitleDefaultColor =  itemTitleDefaultColor
        self.itemTitleSelectedColor =  itemTitleSelectedColor
        self.segmentBorderColor = segmentBorderColor
        self.segmentBgColor =  segmentBgColor
        self.itemDefaultFont =  itemDefaultFont
        self.itemSelectedFont =  itemSelectedFont
        self.itemCornerRadius =  itemCornerRadius
        self.itemTextAlignment =  itemTextAlignment
    }
}

protocol CustomSegmentControlDelegate: AnyObject {
    func change(to index:Int)
}

public final class CustomSegmentControl: UIView {
    
    private var titles: [String]
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    public private(set) var selectedIndex : Int = 0
    weak var delegate:CustomSegmentControlDelegate?
    private var segmentAttributes: CustomSegmentAttributes
    
    public init(frame: CGRect, titles:[String], segmentAttributes: CustomSegmentAttributes = CustomSegmentAttributes()) {
        self.titles = titles
        self.segmentAttributes = segmentAttributes
        super.init(frame: frame)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = self.segmentAttributes.segmentBgColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSelectedValue(index: Int){
        if let buttons = buttons {
            buttonAction(sender: buttons[index])
        }
    }
}

private extension CustomSegmentControl {
    
    func configure() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = self.segmentAttributes.itemMinSpacing
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.titles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = self.segmentAttributes.segmentBgColor
        addSubview(selectorView)
    }
    
    func createButton() {
        if titles.count > 0 {
            buttons = [UIButton]()
            buttons.removeAll()
            subviews.forEach({$0.removeFromSuperview()})
            for buttonTitle in titles {
                let button = UIButton(type: .custom)
                button.setTitle(buttonTitle, for: .normal)
                button.addTarget(self, action:#selector(self.buttonAction(sender:)), for: .touchUpInside)
                button.setTitleColor(self.segmentAttributes.itemTitleDefaultColor, for: .normal)
                button.layer.cornerRadius = self.segmentAttributes.itemCornerRadius
                button.backgroundColor = self.segmentAttributes.itemDefaultColor
                button.titleLabel?.font = self.segmentAttributes.itemDefaultFont
                button.contentHorizontalAlignment = self.segmentAttributes.itemTextAlignment
                buttons.append(button)
            }
            
            if let buttons = buttons, let title = buttons[0].titleLabel?.text {
                buttons[0].titleLabel?.font = self.segmentAttributes.itemSelectedFont
                buttons[0].backgroundColor = self.segmentAttributes.itemSelectedColor
                buttons[0].setTitleColor(self.segmentAttributes.itemTitleSelectedColor, for: .normal)
                buttons[0].addBorder(side: .Bottom, color: self.segmentAttributes.itemDefaultColor, width: 4.0, content:  title, contentFont: self.segmentAttributes.itemSelectedFont)
            }
            delegate?.change(to: selectedIndex)
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(self.segmentAttributes.itemTitleDefaultColor, for: .normal)
            btn.backgroundColor = self.segmentAttributes.itemDefaultColor
            btn.titleLabel?.font = self.segmentAttributes.itemDefaultFont
            btn.removeLayer()
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(titles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.titleLabel?.font = self.segmentAttributes.itemSelectedFont
                if let title = btn.titleLabel?.text {
                    btn.addBorder(side: .Bottom, color: self.segmentAttributes.segmentBorderColor, width: 4.0, content:  title, contentFont: self.segmentAttributes.itemSelectedFont)
                }
                btn.setTitleColor(self.segmentAttributes.itemTitleSelectedColor, for: .normal)
                btn.backgroundColor = self.segmentAttributes.itemSelectedColor
            }
        }
    }
}
