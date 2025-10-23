import SwiftUI

public enum Command: String, CaseIterable {
    case plusMinus
    case calculate
    case allClear
    case clear
    case delete

    public var text: Text {
        switch self {
        case .plusMinus:
            Text(Image(systemName: "plus.slash.minus"))
        case .calculate:
            Text(Image(systemName: "equal"))
        case .allClear:
            Text(verbatim: "AC")
        case .clear:
            Text(verbatim: "C")
        case .delete:
            Text(Image(systemName: "delete.backward"))
        }
    }
}
