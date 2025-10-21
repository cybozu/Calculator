import SwiftUI

struct ScrollPlacePreferenceKey: PreferenceKey {
    static let defaultValue = ScrollPlace.fit

    static func reduce(value _: inout ScrollPlace, nextValue: () -> ScrollPlace) {
        _ = nextValue()
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue = Double.zero

    static func reduce(value: inout Double, nextValue: () -> Double) {
        _ = nextValue()
    }
}
