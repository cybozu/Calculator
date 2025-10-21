import Foundation

enum CalculatorError: LocalizedError {
    case undefined

    var errorDescription: String? {
        let localizationValue: String.LocalizationValue = switch self {
        case .undefined:
            "undefined"
        }
        return String(localized: localizationValue, bundle: .module)
    }
}
