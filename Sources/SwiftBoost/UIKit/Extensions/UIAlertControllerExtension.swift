#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIAlertController {
    
    convenience init(title: String, message: String? = nil, actionButtonTitle: String) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
    }
    
    convenience init(title: String, error: Error, actionButtonTitle: String) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
    }
    
    @discardableResult func addAction(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
        return action
    }
    
    func addTextField(text: String? = nil, placeholder: String? = nil, editingChangedTarget: Any?, editingChangedSelector: Selector?) {
        addTextField { textField in
            textField.text = text
            textField.placeholder = placeholder
            if let target = editingChangedTarget, let selector = editingChangedSelector {
                textField.addTarget(target, action: selector, for: .editingChanged)
            }
        }
    }
    
    @available(iOS 14, tvOS 14, *)
    func addTextField(
        text: String? = nil,
        placeholder: String? = nil,
        action: UIAction?
    ) {
        addTextField { textField in
            textField.text = text
            textField.placeholder = placeholder
            if let action = action {
                textField.addAction(action, for: .editingChanged)
            }
        }
    }
    
    static func confirm(title: String, description: String, actionTitle: String, cancelTitle: String, desctructive: Bool, completion: @escaping (_ confirmed: Bool)->Void, sourceView: UIView, on controller: UIViewController) {
        let alertController = UIAlertController.init(title: title, message: description, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.addAction(title: actionTitle, style: desctructive ? .destructive : .default) { [] _ in
            completion(true)
        }
        alertController.addAction(title: cancelTitle, style: .cancel, handler: { _ in
            completion(false)
        })
        controller.present(alertController)
    }
    
    static func confirmDouble(title: String, description: String, actionTitle: String, cancelTitle: String, desctructive: Bool, completion: @escaping (_ confirmed: Bool)->Void, sourceView: UIView, on controller: UIViewController) {
        confirm(title: title, description: description, actionTitle: actionTitle, cancelTitle: cancelTitle, desctructive: desctructive, completion: { confirmed in
            if confirmed {
                confirm(title: title, description: description, actionTitle: actionTitle, cancelTitle: cancelTitle, desctructive: desctructive, completion: completion, sourceView: sourceView, on: controller)
            } else {
                completion(false)
            }
        }, sourceView: sourceView, on: controller)
    }
}
#endif
