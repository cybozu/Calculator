import SwiftUI

public struct CalculatorStyleConfiguration {
    public var value: String
    public var rows: [Row]
    public var trigger: (Role) -> Void
}

public protocol CalculatorStyle: Sendable {
    associatedtype Body: View

    @MainActor func makeBody(configuration: Configuration) -> Body

    typealias Configuration = CalculatorStyleConfiguration
}

public struct ClassicCalculatorStyle: CalculatorStyle {
    private var buttonFontSize: Double
    private var buttonBorderShape: ButtonBorderShape

    public init(buttonFontSize: Double = 20, buttonBorderShape: ButtonBorderShape = .capsule) {
        self.buttonFontSize = buttonFontSize
        self.buttonBorderShape = buttonBorderShape
    }

    public func makeBody(configuration: ClassicCalculatorStyle.Configuration) -> some View {
        ClassicCalculatorView(
            configuration: configuration,
            buttonFontSize: buttonFontSize,
            buttonBorderShape: buttonBorderShape
        )
    }
}

public extension CalculatorStyle where Self == ClassicCalculatorStyle {
    static func classic(
        buttonFontSize: Double = 20,
        buttonBorderShape: ButtonBorderShape = .capsule
    ) -> Self {
        ClassicCalculatorStyle(
            buttonFontSize: buttonFontSize,
            buttonBorderShape: buttonBorderShape
        )
    }
}

public struct DefaultCalculatorStyle: CalculatorStyle {
    public init() {}

    public func makeBody(configuration: DefaultCalculatorStyle.Configuration) -> some View {
        ClassicCalculatorStyle().makeBody(configuration: configuration)
    }
}

public extension CalculatorStyle where Self == DefaultCalculatorStyle {
    static var automatic: Self { Self() }
}
