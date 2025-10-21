import SwiftUI

struct Indicator: View {
    var expression: String
    var fontSize: Double
    var width: Double

    @State private var scrollPlace = ScrollPlace.fit

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                Text(expression)
                    .font(.system(size: fontSize, weight: .semibold, design: .monospaced))
                    .lineLimit(1)
                    .foregroundStyle(Color.primary)
                    .frame(minWidth: width, alignment: .trailing)
                    .id("expression")
                    .background {
                        GeometryReader { proxy in
                            Color.clear.preference(
                                key: ScrollPlacePreferenceKey.self,
                                value: ScrollPlace(width: width, frame: proxy.frame(in: .named("scroll")))
                            )
                        }
                    }
            }
            .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
            .frame(width: width)
            .mask(scrollPlace.mask)
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollPlacePreferenceKey.self) { value in
                MainActor.assumeIsolated {
                    scrollPlace = value
                }
            }
            .onChange(of: expression) { _, newValue in
                proxy.scrollTo("expression", anchor: .trailing)
            }
        }
    }
}
