import SwiftUI
import SwiftUINavigation

private struct ResizableSheetModifier<Enum, ChildCase, ParentCase, SheetContent: View>: ViewModifier {
    @State private var detentHeight: CGFloat = 0

    let `enum`: Binding<Enum?>
    let childCasePath: CasePath<ParentCase?, ChildCase>
    let parentCasePath: CasePath<Enum, ParentCase?>
    let onDismiss: (() -> Void)?
    let sheetContent: (Binding<ChildCase>) -> SheetContent

    func body(content: Content) -> some View {
        content
            .sheet(
                unwrapping: `enum`,
                childCase: childCasePath,
                parentCase: parentCasePath,
                onDismiss: onDismiss,
                content: { childCase in
                    sheetContent(childCase)
                        .padding(.top)
                        .observeHeight { height in
                            detentHeight = height
//                            print("height: \(height)")
                        }
                        .presentationDetents([.height(detentHeight)])
                        .presentationDragIndicator(.visible)
                }
            )
    }
}

public extension View {
    // TODO: does not work with NavigationStack
    // works only with simple Views
    @MainActor func resizableSheet<Enum, ChildCase, ParentCase, Content: View>(
        unwrapping enum: Binding<Enum?>,
        childCase childCasePath: CasePath<ParentCase?, ChildCase>,
        parentCase parentCasePath: CasePath<Enum, ParentCase?>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Binding<ChildCase>) -> Content
    ) -> some View {
        self.modifier(
            ResizableSheetModifier(
                enum: `enum`,
                childCasePath: childCasePath,
                parentCasePath: parentCasePath,
                onDismiss: onDismiss,
                sheetContent: content
            )
        )
    }
}
