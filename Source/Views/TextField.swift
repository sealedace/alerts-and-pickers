import UIKit

open class TextField: UITextField {
    
    public typealias Config = (TextField) -> Swift.Void
    
    public func configure(configurate: Config?) {
        configurate?(self)
    }
    
    public typealias Action = (UITextField) -> Void
    
    fileprivate var actionEditingChanged: Action?
    
    // Provides left padding for images
    
    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftViewPadding ?? 0
        return textRect
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let dx1 = (leftTextPadding ?? 8)
        let dx2 = (leftView?.width ?? 0)
        let dx3 = (leftViewPadding ?? 0)
        return bounds.insetBy(dx: dx1+dx2+dx3, dy: 0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let dx1 = (leftTextPadding ?? 8)
        let dx2 = (leftView?.width ?? 0)
        let dx3 = (leftViewPadding ?? 0)
        return bounds.insetBy(dx: dx1+dx2+dx3, dy: 0)
    }
    
    
    public var leftViewPadding: CGFloat?
    public var leftTextPadding: CGFloat?
    
    
    public func action(closure: @escaping Action) {
        if actionEditingChanged == nil {
            addTarget(self, action: #selector(TextField.textFieldDidChange), for: .editingChanged)
        }
        actionEditingChanged = closure
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        actionEditingChanged?(self)
    }
}
