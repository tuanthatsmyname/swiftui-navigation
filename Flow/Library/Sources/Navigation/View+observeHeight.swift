import SwiftUI

private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct ReadHeightModifier: ViewModifier {
    let onHeightChanged: (CGFloat) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { height in
                onHeightChanged(height)
            }
    }
}

public extension View {
    func observeHeight(onHeightChanged: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(ReadHeightModifier(onHeightChanged: onHeightChanged))
    }
}
