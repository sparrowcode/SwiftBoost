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

public protocol UIFadeOut {}

extension UIFadeOut where Self: UIView {
    
    /**
     SparrowKit: Hide view with fade out animation.
     
     - parameter duration: Duration of all animation.
     - parameter delay: Pause when view dissapear in middle of animation.
     - parameter work: Apply view changes here.
     - parameter completion: Call after end of animation.
     */
    public func fadeUpdate(duration: TimeInterval = 1, delay: TimeInterval = 0.15, work: @escaping (Self)->Void, completion: (()->Void)? = nil) {
        let partDuration = (duration - delay) / 2
        let storedAlpha = self.alpha
        UIView.animate(withDuration: partDuration, delay: .zero, options: [.beginFromCurrentState, .allowUserInteraction], animations: { [weak self] in
            self?.alpha = .zero
        }, completion: { [weak self] finished in
            if let self = self {
                work(self)
            }
            UIView.animate(withDuration: partDuration, delay: delay, options: [.beginFromCurrentState, .allowUserInteraction], animations: { [weak self] in
                self?.alpha = storedAlpha
            }, completion: { finished in
                completion?()
            })
        })
    }
}

extension UIView: UIFadeOut {}

#endif

