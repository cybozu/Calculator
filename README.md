# Calculator

Calculator is a Swift package that provides an inline calculator with SwiftUI API.

<img width="355" height="355" src="https://github.com/user-attachments/assets/e2f37975-b820-48c2-b7ba-0064249b9a86" />

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
            .calculatorStyle(.classic(
                buttonFontSize: 32,
                buttonBorderShape: .roundedRectangle
            ))
    }
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

## Demo

This repository includes demonstration app for iOS & macOS.

Open [Example/Example.xcodeproj](/Example/Example.xcodeproj) and Run it.
