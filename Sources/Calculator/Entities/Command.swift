import SwiftUI

enum Command: String {
    case plusMinus
    case calculate
    case allClear
    case clear
    case delete

    var text: Text {
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
