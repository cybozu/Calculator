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

public struct DefaultCalculatorStyle: CalculatorStyle {
    public init() {}

    public func makeBody(configuration: DefaultCalculatorStyle.Configuration) -> some View {
        PlainView(configuration: configuration)
    }

    struct PlainView: View {
        @State private var width = Double.zero
        @ScaledMetric private var buttonFontSize: Double
        @ScaledMetric private var spacing: Double
        @ScaledMetric private var cornerRadius: Double
        private var configuration: CalculatorStyleConfiguration

        init(
            configuration: CalculatorStyleConfiguration,
            buttonFontSize: Double = 20
        ) {
            self.configuration = configuration
            _buttonFontSize = .init(wrappedValue: buttonFontSize, relativeTo: .title)
            _spacing = .init(wrappedValue: 0.4 * buttonFontSize, relativeTo: .title)
            _cornerRadius = .init(wrappedValue: 0.8 * buttonFontSize, relativeTo: .title)
        }

        var body: some View {
            VStack(spacing: spacing) {
                Indicator(
                    expression: configuration.value,
                    fontSize: 1.5 * buttonFontSize,
                    width: width
                )
                Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
                    ForEach(configuration.rows) { row in
                        GridRow {
                            ForEach(row.cells) { cell in
                                Button {
                                    configuration.trigger(cell.role)
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
        }
    }
}

public extension CalculatorStyle where Self == DefaultCalculatorStyle {
    static var automatic: Self { Self() }
}
