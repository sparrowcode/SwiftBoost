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

extension SPDimmedButton {
 
    /**
     SparrowKit: Represent colors for state of button for elements.
     */
    public struct Colorise {
        
        public var title: Mode
        public var icon: Mode
        public var background: Mode
        
        /**
         SparrowKit: This init allow create colorise with automatically tint oberving.
         
         - parameter content: Colorise mode for `title` & `icon`.
         - parameter background: Colorise mode for background.
         */
        public init(content: Mode, background: Mode) {
            self.title = content
            self.icon = content
            self.background = background
        }
        
        /**
         - parameter content: Color for `title` & `icon`.
         - parameter background: Color for background.
         */
        public init(content: UIColor, background: UIColor) {
            self.title = .custom(content)
            self.icon = .custom(content)
            self.background = .custom(background)
        }
        
        /**
         - parameter content: Color for `title` & `icon`.
         - parameter background: Color for image.
         - parameter background: Color for background.
         */
        public init(content: UIColor, icon: UIColor, background: UIColor) {
            self.title = .custom(content)
            self.icon = .custom(icon)
            self.background = .custom(background)
        }
        
        /**
         SparrowKit: Represent of rendering colors in button.
         
         It need for have dynamic tint color and fixed custom.
         */
        public enum Mode {
            
            /**
             SparrowKit: Always specific color.
             */
            case custom(UIColor)
            
            /**
             SparrowKit: Observe and apply tint color of button.
             */
            case tint
            
            /**
             SparrowKit: Observe and apply secondary tint color of button.
             */
            case secondaryTint
        }
        
        // MARK: - Ready Use
        
        public static var tintedContent: Colorise {
            return .init(content: .tint, background: .custom(.clear))
        }
        
        #if os(iOS)
        @available(iOS 13.0, *)
        public static var tintedContentSecondaryBackground : Colorise {
            return .init(content: .tint, background: .custom(.secondarySystemBackground))
        }
        
        @available(iOS 13.0, *)
        public static var tintedContentTertiaryBackground : Colorise {
            return .init(content: .tint, background: .custom(.tertiarySystemBackground))
        }
        
        @available(iOS 13.0, *)
        public static var tintedContentSecondaryGroupBackground : Colorise {
            return .init(content: .tint, background: .custom(.secondarySystemGroupedBackground))
        }
        
        @available(iOS 13.0, *)
        public static var tintedContentTertiaryGroupBackground : Colorise {
            return .init(content: .tint, background: .custom(.tertiarySystemGroupedBackground))
        }
        #endif
        
        public static var tintedColorful: Colorise {
            return .init(content: .custom(.white), background: .tint)
        }
        
        public static var tinted: Colorise {
            return .init(content: .tint, background: .secondaryTint)
        }
    }
}
#endif

