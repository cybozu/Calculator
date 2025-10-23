import SwiftUI

public struct Calculator: View {
    @Environment(\.calculatorStyle) private var _calculatorStyle
    @State private var engine = CalculatorEngine()

    @Binding var value: String

    public init(value: Binding<String>) {
        _value = value
        engine.setValue(value.wrappedValue)
    }

    public var body: some View {
        AnyView(_calculatorStyle.makeBody(configuration: .init(
            value: engine.expression,
            rows: engine.rows,
            trigger: { engine.onTap($0) }
        )))
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("calculator")
        .onChange(of: value) { _, newValue in
            guard engine.expression != newValue else { return }
            engine.setValue(newValue)
        }
        .onChange(of: engine.modifiedDate, initial: true) { _, _ in
            let expression = engine.expression
            guard value != expression else { return }
            value = expression
        }
    }
}
