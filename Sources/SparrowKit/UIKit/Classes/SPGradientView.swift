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

#if canImport(UIKit) && (os(iOS))
import UIKit

/**
 SparrowKit: View with gradeint.
 
 Inside using `CAGradientLayer`, but you can use interfaace for clean access to it.
 */
open class SPGradientView: SPView {
    
    /**
     SparrowKit: Gradient layer which configure.
     */
    open var gradientLayer = CAGradientLayer()
    
    /**
     SparrowKit: Start color for gradient view. Not same to top, but can be in top.
     */
    open var startColor = UIColor.white {
        didSet {
            updateGradient()
        }
    }
    
    /**
     SparrowKit: End color for gradient view. Not same to bottom, but can be in bottom.
     */
    open var endColor = UIColor.black {
        didSet {
            updateGradient()
        }
    }
    
    /**
     SparrowKit: Start color position for start color.
     */
    open var startColorPosition = Position.topLeft  {
        didSet {
            updateGradient()
        }
    }
    
    /**
     SparrowKit: End color position for end color.
     */
    open var endColorPosition = Position.bottomRight  {
        didSet {
            updateGradient()
        }
    }
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Lifecycle
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateGradient()
    }
    
    // MARK: - Layout
    
    open override func layoutSublayers(of layer: CALayer) {
        gradientLayer.frame = self.bounds
        super.layoutSublayers(of: layer)
    }
    
    // MARK: - Helpers
    
    private func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = startColorPosition.point
        gradientLayer.endPoint = endColorPosition.point
    }
    
    // MARK: - Models
    
    /**
     SparrowKit: Represent position to gradient view.
     */
    public enum Position {
        
        case topLeft
        case topCenter
        case topRight
        case bottomLeft
        case bottomCenter
        case bottomRight
        case mediumLeft
        case mediumRight
        case mediumCenter
        
        /**
         SparrowKit: Convert position to point for using with `CAGradientLayer`.
         */
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint.init(x: 0, y: 0)
            case .topCenter:
                return CGPoint.init(x: 0.5, y: 0)
            case .topRight:
                return CGPoint.init(x: 1, y: 0)
            case .bottomLeft:
                return CGPoint.init(x: 0, y: 1)
            case .bottomCenter:
                return CGPoint.init(x: 0.5, y: 1)
            case .bottomRight:
                return CGPoint.init(x: 1, y: 1)
            case .mediumLeft:
                return CGPoint.init(x: 0, y: 0.5)
            case .mediumRight:
                return CGPoint.init(x: 1, y: 0.5)
            case .mediumCenter:
                return CGPoint.init(x: 0.5, y: 0.5)
            }
        }
    }
}
#endif
