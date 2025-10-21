# Calculator

Calculator is a Swift package that provides an inline calculator with SwiftUI API.

<img width="355" height="355" src="https://github.com/user-attachments/assets/a013d3ab-ff6b-4b8e-83eb-964d1e0f826b" />

## Requirements

- Development with Xcode 26.0+
- Written in Swift 6.2
- Compatible with iOS 26.0+, macOS 15.0+

## Usage

```swift
import Calculator
import SwiftUI

struct ContentView: View {
    @State var value: String = ""

    var body: some View {
        Calculator(value: $value)
    }
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

## Demo

This repository includes demonstration app for iOS & macOS.

Open [Example/Example.xcodeproj](/Example/Example.xcodeproj) and Run it.
