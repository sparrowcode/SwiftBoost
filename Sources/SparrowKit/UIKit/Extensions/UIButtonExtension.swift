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

extension UIButton {
    
    /**
     SparrowKit: Set title for all states.
     
     - parameter title: Title for button.
     */
    open func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
    
    /**
     SparrowKit: Set title color for all states.
     Also adding higlight color automatically for clear press event.
     
     - parameter color: Color of title.
     */
    open func setTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
        setTitleColor(color.withAlphaComponent(0.7), for: .highlighted)
    }
    
    /**
     SparrowKit: Set image for all states.
     
     - parameter image: Image for button.
     */
    open func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .disabled)
    }
    
    /**
     SparrowKit: Remove all targets.
     */
    @available(*, deprecated, renamed: "removeTargetsAndActions")
    open func removeAllTargets() {
        self.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    /**
     SparrowKit: Remove all targets and actions.
     */
    open func removeTargetsAndActions() {
        self.removeTarget(nil, action: nil, for: .allEvents)
    }
}
#endif
