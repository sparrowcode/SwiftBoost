// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIAlertController {
    
    // MARK: - Init
    
    /**
     SparrowKit: Create Alert Controller.
     
     This init allow create with action button and simple hide after tap to this action button.
     
     - parameter title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
     - parameter message: Descriptive text that provides additional details about the reason for the alert.
     - parameter actionButtonTitle: Title of the action button. By tap this button alert will close.
     */
    convenience init(title: String, message: String? = nil, actionButtonTitle: String) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
    }
    
    /**
     SparrowKit: Create Alert Controller.
     
     This init allow create with action button and simple hide after tap to this action button.
     In description automatically process error.
     
     - parameter title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
     - parameter error: Descriptive text that provides additional details about the reason for the alert.
     - parameter actionButtonTitle: Title of the action button. By tap this button alert will close.
     */
    convenience init(title: String, error: Error, actionButtonTitle: String) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
    }
    
    // MARK: - Helpers
    
    /**
     SparrowKit: Add action to Alert Controller.
     
     - parameter title: The text to use for the button title.
     - parameter style: Additional styling information to apply to the button. Use the style information to convey the type of action that is performed by the button.
     - parameter handler: A block to execute when the user selects the action.
     */
    @discardableResult func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
            
            let action = UIAlertAction(title: title, style: style, handler: handler)
            addAction(action)
            return action
        }
    
    /**
     SparrowKit: Add Text Field to Alert Controller.
     
     - parameter text: Initial text for Text Field.
     - parameter placeholder: Placeholder text. Show when  Text Field test is empty.
     - parameter editingChangedTarget: Target for observe when text changed.
     - parameter editingChangedSelector: Selector for observe when text changed.
     */
    func addTextField(
        text: String? = nil,
        placeholder: String? = nil,
        editingChangedTarget: Any?,
        editingChangedSelector: Selector?
    ) {
        addTextField { textField in
            textField.text = text
            textField.placeholder = placeholder
            if let target = editingChangedTarget, let selector = editingChangedSelector {
                textField.addTarget(target, action: selector, for: .editingChanged)
            }
        }
    }
    
    /**
     SparrowKit: Add Text Field to Alert Controller.
     
     - parameter text: Initial text for Text Field.
     - parameter placeholder: Placeholder text. Show when  Text Field test is empty.
     - parameter action: Performs action in a closure when text changed.
     */
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
