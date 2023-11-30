# SwiftBoost

Collection of Swift-extensions to boost development process.

### iOS Dev Community

<p float="left">
    <a href="https://twitter.com/i/communities/1730194338489987403">
        <img src="https://cdn.sparrowcode.io/github/badges/x-community.png?version=1" height="52">
    </a>
</p>

## Installation

Ready to use on iOS 13+, tvOS 13+, watchOS 6.0+.

### Swift Package Manager

In Xcode go to Project -> Your Project Name -> `Package Dependencies` -> Tap *Plus*. Insert url:

```
https://github.com/sparrowcode/SwiftBoost
```

or adding it to the `dependencies` of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.8"))
]
```

### CocoaPods:

This is an outdated way of doing things. I advise you to use [SPM](#swift-package-manager). However, I will continue to support Cocoapods for some time.

<details><summary>Cocoapods Instalation</summary>

[CocoaPods](https://cocoapods.org) is a dependency manager. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SwiftBoost'
```
</details>

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/SwiftBoost` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.
