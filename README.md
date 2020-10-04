# SparrowKit
Collection of native Swift extensions to boost your development.
If you have time, please, add description and docs for functions.

If you like the project, don't forget to `put star ★` and follow me on GitHub:

[![https://github.com/ivanvorobei](https://github.com/ivanvorobei/Assets/blob/master/Buttons/follow-me-on-github.svg)](https://github.com/ivanvorobei)

## Navigate

- [Requirements](#requirements)
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
- [Other Projects](#other-projects)
- [Russian Community](#russian-community)

## Requirements

Swift `5.0`. Ready for use on iOS 12+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `SparrowKit` into your Xcode project using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/ivanvorobei/SparrowKit
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `SparrowKit` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SparrowKit'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate `SparrowKit` into your project manually. Put `Source/SparrowKit` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

### Manually

If you prefer not to use any of dependency managers, you can integrate `SPPermissions` into your project manually. Put `Source/SPPermissions` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

After it need add configuration. See example [SPPermissionsConfiguration.xcconfig](https://github.com/ivanvorobei/SPPermissions/blob/master/Source/SPPermissions/Supporting%20Files/SPPermissionsConfiguration.xcconfig) file or example project. If you don't know how add configuration file, see this [short video](https://youtu.be/1kR5HGVhJfk).

## Other Projects

#### [SPPermissions](https://github.com/ivanvorobei/SPPermissions)
Allow request permissions with native dialog UI and interactive animations. Also you can request permissions without dialog. Check state any permission. You can start using this project with just two lines of code and easy customisation.

#### [SPAlert](https://github.com/ivanvorobei/SPAlert)
It is popup from Apple Music & Feedback in AppStore. Contains Done & Heart presets. Done present with draw path animation. I clone Apple's alerts as much as possible.
You can find this alerts in AppStore after feedback, after added song to library in Apple Music. I am also add alert without icon, as simple message.

#### [SPDiffable](https://github.com/ivanvorobei/SPDiffable)
Apple's diffable API requerid models for each object type. If you want use it in many place, you pass many time to implemenet and get over duplicates codes. This project help you do it elegant with shared models and special cell providers for one-usage models.

## Russian Community

Присоединяйтесь в телеграм канал [Код Воробья](https://sparrowcode.by/telegram), там найдете заметки о iOS разработке и дизайне.
Большие туториалы выклыдываю на [YouTube](https://sparrowcode.by/youtube).

[![Tutorials on YouTube](https://github.com/ivanvorobei/Assets/blob/master/Russian%20Community/youtube-preview.jpg)](https://sparrowcode.by/youtube)
