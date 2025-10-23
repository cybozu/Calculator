import SwiftUI

extension View {
    public func calculatorStyle(_ style: some CalculatorStyle) -> some View {
        environment(\.calculatorStyle, style)
    }
}
