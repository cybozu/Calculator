import SwiftUI

public struct Calculator: View {
    @Binding var value: String

    @State private var engine = CalculatorEngine()
    @State private var width = Double.zero
    @ScaledMetric private var buttonFontSize: Double
    @ScaledMetric private var spacing: Double
    @ScaledMetric private var cornerRadius: Double

    public init(value: Binding<String>, buttonFontSize: Double = 20) {
        _value = value
        _buttonFontSize = .init(wrappedValue: buttonFontSize, relativeTo: .title)
        _spacing = .init(wrappedValue: 0.4 * buttonFontSize, relativeTo: .title)
        _cornerRadius = .init(wrappedValue: 0.8 * buttonFontSize, relativeTo: .title)
        engine.setValue(value.wrappedValue)
    }

    public var body: some View {
        VStack(spacing: spacing) {
            Indicator(
                expression: engine.expression,
                fontSize: 1.5 * buttonFontSize,
                width: width
            )
            Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
                ForEach(engine.rows) { row in
                    GridRow {
                        ForEach(row.cells) { cell in
                            Button {
                                engine.onTap(cell.role)
                            } label: {
                                ZStack {
                                    Text(verbatim: "AC").hidden()
                                    cell.role.text
                                }
                                .font(.system(size: buttonFontSize, weight: .bold))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .foregroundStyle(Color.white)
                            }
                            .tint(cell.area.color)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .accessibilityIdentifier(cell.role.accessibilityIdentifier)
                        }
                    }
                }
            }
            .fixedSize()
            .background {
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: WidthPreferenceKey.self,
                        value: proxy.size.width
                    )
                }
            }
            .onPreferenceChange(WidthPreferenceKey.self) { value in
                MainActor.assumeIsolated {
                    width = value
                }
            }
        }
        .padding(2 * spacing)
        .background(Color.background, in: .rect(cornerRadius: cornerRadius))
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
