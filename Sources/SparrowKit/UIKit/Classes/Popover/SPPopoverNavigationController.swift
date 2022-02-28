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

#if canImport(UIKit) && os(iOS)
import UIKit

/**
 SparrowKit: Popover controller, work even in iPhones.
 Use like usuall navigation controller.
 */
open class SPPopoverNavigationController: SPNavigationController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Init
    
    public init(rootViewController: UIViewController, size: CGSize, sourceView: UIView, sourceRect: CGRect, permittedArrowDirections: UIPopoverArrowDirection) {
        super.init(rootViewController: rootViewController)
        preferredContentSize = size
        popoverPresentationController?.permittedArrowDirections = permittedArrowDirections
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.sourceRect = sourceRect
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func commonInit() {
        super.commonInit()
        modalPresentationStyle = .popover
        popoverPresentationController?.delegate = self
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
#endif
