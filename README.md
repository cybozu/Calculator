# Calculator

Calculator is a Swift package that provides an inline calculator with SwiftUI API.

<img width="352" height="352" src="https://github.com/user-attachments/assets/2fd08868-84b2-4ff0-82a3-ef46be32986e" />

## Requirements

- Development with Xcode 26.0+
- Written in Swift 6.2
- Compatible with iOS 26.0+, macOS 15.0+

## Documentation

[Latest (Swift-DocC)](https://cybozu.github.io/Calculator/documentation/calculator/)

## Usage

If you want to use the classic preset calculator:

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

If you want to create your own preferred calculator interface:

```swift
import Calculator
import SwiftUI

struct CustomCalculatorStyle: CalculatorStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Text(configuration.value)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(4)
                .background(Color(.separator), in: .rect(cornerRadius: 8))
            ForEach(configuration.rows) { row in
                HStack {
                    ForEach(row.cells) { cell in
                        Button {
                            configuration.trigger(cell.role)
                        } label: {
                            cell.role.text
                                .frame(width: 40, height: 32)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .fixedSize()
    }
}

extension CalculatorStyle where Self == CustomCalculatorStyle {
    static var custom: CustomCalculatorStyle { .init() }
}

struct ContentView: View {
    @State var value: String = ""

    var body: some View {
        Calculator(value: $value)
            .calculatorStyle(.custom)
    }
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

## Demo

This repository includes demonstration app for iOS & macOS.

Open [Example/Example.xcodeproj](/Example/Example.xcodeproj) and Run it.
