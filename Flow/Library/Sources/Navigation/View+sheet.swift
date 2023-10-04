import SwiftUI
import SwiftUINavigation

public extension View {
    @MainActor func sheet<Enum, ChildCase, ParentCase, Content: View>(
        unwrapping enum: Binding<Enum?>,
        childCase childCasePath: CasePath<ParentCase?, ChildCase>,
        parentCase parentCasePath: CasePath<Enum, ParentCase?>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Binding<ChildCase>) -> Content
    ) -> some View {
        self.sheet(
            unwrapping: Binding(
                get: {
                    `enum`.wrappedValue
                },
                set: { _ in
                    `enum`.wrappedValue = parentCasePath.embed(nil)
                }
            ),
            case: parentCasePath .. childCasePath,
            onDismiss: onDismiss,
            content: content
        )
    }
}
