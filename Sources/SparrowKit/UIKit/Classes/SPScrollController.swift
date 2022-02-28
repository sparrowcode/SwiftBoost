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
 SparrowKit: Basic Scroll Controller.
 */
open class SPScrollController: SPController, UIScrollViewDelegate {
    
    // MARK: - Views
    
    public let scrollView = SPScrollView().do {
        $0.backgroundColor = .clear
        $0.delaysContentTouches = false
        $0.showsHorizontalScrollIndicator = false
        $0.preservesSuperviewLayoutMargins = true
        $0.alwaysBounceVertical = true
        $0.alwaysBounceHorizontal = false
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
        view.addSubview(scrollView)
        scrollView.setEqualSuperviewBoundsWithAutoresizingMask()
        scrollView.delegate = self
        
        #if targetEnvironment(macCatalyst)
        
        #else
        if #available(iOS 15.0, tvOS 15.0, *) {
            setContentScrollView(scrollView)
        }
        #endif
    }
}
#endif
