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

/**
 SparrowKit: Basic Collection Reusable View class.
 
 It has one shared init `commonInit` which call for all default inits.
 */
open class SPCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Private
    
    open var inhertHorizontalMarginsFromCollection: Bool = true
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /**
     SparrowKit: Wrapper of init.
     Called in each init and using for configuration.
     
     No need ovveride other init. Using one function for configurate view.
     */
    open func commonInit() {}
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if inhertHorizontalMarginsFromCollection, let collectionView = self.superview as? UICollectionView {
            setLayoutMargins(
                .init(
                    top: layoutMargins.top,
                    left: collectionView.layoutMargins.left,
                    bottom: layoutMargins.bottom,
                    right: collectionView.layoutMargins.right
                )
            )
        }
    }
}
#endif
