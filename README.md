# SwiftBoost

Collection of Swift-extensions to boost development process.
 
### Community

<p float="left">
    <a href="https://discord.gg/K9SKMTKVNH">
        <img src="https://cdn.sparrowcode.io/github/badges/discord.png?version=2" height="52">
    </a>
    <a href="#apps-using">
        <img src="https://cdn.sparrowcode.io/github/badges/download-on-the-appstore.png?version=2" height="52">
    </a>
    <a href="https://github.com/sponsors/sparrowcode">
        <img src="https://cdn.sparrowcode.io/github/badges/github-sponsor.png?version=3" height="52">
    </a>
</p>

## Installation

Ready to use on iOS 13+, tvOS 13+, watchOS 6.0+.

### Swift Package Manager

In Xcode go to `File` -> `Packages` -> `Update to Latest Package Versions` and insert url: 

```
https://github.com/sparrowcode/SwiftBoost
```

or adding it to the `dependencies` value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.0"))
]
```

### CocoaPods:

Specify it in your `Podfile`:

```ruby
pod 'SwiftBoost'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/SwiftBoost` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Extensions

- [Foundation](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/Foundation)
    - [Array](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/ArrayExtension.swift)
    - [Bool](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/BoolExtension.swift)
    - [Calendar](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/CalendarExtension.swift)
    - [Collection](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/CollectionExtension.swift)
    - [Closures](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Typealiases/ClosuresExtension.swift)
    - [Date](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/DateExtension.swift)
    - [Delay](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Delay.swift)
    - [Do](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Do.swift)
    - [Locale](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/LocaleExtension.swift)
    - [Logger](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Logger.swift)
    - [NotificationCenter](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/NotificationCenterExtension.swift)
    - [NSObject](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/NSObjectExtension.swift)
    - [String](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/StringExtension.swift)
    - [UserDefaults](https://github.com/sparrowcode/SwiftBoost/blob/main/Sources/SwiftBoost/Foundation/Extensions/UserDefaultsExtension.swift)
- [UIKit](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit)
    - [UIAlertController](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIAlertControllerExtension.swift)
    - [UIApplication](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIApplicationExtension.swift)
    - [UIBezierPath](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIBezierPathExtension.swift)
    - [UIButton](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIButtonExtension.swift)
    - [UICollectionView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UICollectionViewExtension.swift)
    - [UIColor](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIColorExtension.swift)
    - [UIDevice](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIDeviceExtension.swift)
    - [UIEdgeInsets](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIEdgeInsetsExtension.swift)
    - [UIFeedbackGenerator](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIFeedbackGeneratorExtension.swift)
    - [UIFont](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIFontExtension.swift)
    - [UIGestureRecognizer](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIGestureRecognizerExtension.swift)
    - [UIImage](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIImageExtension.swift)
    - [UIImageView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIImageViewExtension.swift)
    - [UILabel](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UILabelExtension.swift)
    - [UINavigationBar](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UINavigationBarExtension.swift)
    - [UINavigationController](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UINavigationControllerExtension.swift)
    - [UIScrollView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIScrollViewExtension.swift)
    - [UISegmentedControl](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UISegmentedControlExtension.swift)
    - [UISlider](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UISliderExtension.swift)
    - [UITabBarController](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UITabBarControllerExtension.swift)
    - [UITabBar](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UITabBarExtension.swift)
    - [UITableView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UITableViewExtension.swift)
    - [UITextView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UITextViewExtension.swift)
    - [UIViewController](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIViewControllerExtension.swift)
    - [UIView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIViewExtension.swift)
    - [UIVisualEffectView](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/UIKit/Extensions/UIVisualEffectViewExtension.swift)
- [CoreGraphics](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/CoreGraphics)
    - [CGAffineTransform](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/CoreGraphics/Extensions/CGAffineTransformExtension.swift)
    - [CGPoint](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/CoreGraphics/Extensions/CGPointExtension.swift)
    - [CGRect](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/CoreGraphics/Extensions/CGRectExtension.swift)
    - [CGSize](https://github.com/sparrowcode/SwiftBoost/tree/main/Sources/SwiftBoost/CoreGraphics/Extensions/CGSizeExtension.swift)

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/app/id1624477055"><img src="https://cdn.sparrowcode.io/github/apps-using/id1624477055.png?version=2" height="65"></a>
    <a href="https://apps.apple.com/app/id1625641322"><img src="https://cdn.sparrowcode.io/github/apps-using/id1625641322.png?version=2" height="65"></a>
    <a href="https://apps.apple.com/app/id875280793"><img src="https://cdn.sparrowcode.io/github/apps-using/id875280793.png?version=2" height="65"></a>
    <a href="https://apps.apple.com/app/id743843090"><img src="https://cdn.sparrowcode.io/github/apps-using/id743843090.png?version=2" height="65"></a>
    <a href="https://apps.apple.com/app/id537070378"><img src="https://cdn.sparrowcode.io/github/apps-using/id537070378.png?version=2" height="65"></a>
    <a href="https://apps.apple.com/app/id1570676244"><img src="https://cdn.sparrowcode.io/github/apps-using/id1570676244.png?version=2" height="65"></a>
    <a href="https://apps.apple.com/app/id1617055933"><img src="https://cdn.sparrowcode.io/github/apps-using/id1617055933.png?version=2" height="65"></a>
</p>
