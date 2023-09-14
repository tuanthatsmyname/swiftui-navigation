import Foundation
import SwiftUI
@_exported import SwiftUINavigation

public extension View {
    func navigationDestination<Enum, ChildCase, ParentCase, Destination: View>(
        unwrapping enum: Binding<Enum?>,
        childCase childCasePath: CasePath<ParentCase?, ChildCase>,
        parentCase parentCasePath: CasePath<Enum, ParentCase?>,
        @ViewBuilder destination: (Binding<ChildCase>) -> Destination
    ) -> some View {
        self.navigationDestination(
            unwrapping: Binding(
                get: {
                    `enum`.wrappedValue
                },
                set: { _ in
                    `enum`.wrappedValue = parentCasePath.embed(nil)
                }
            ),
            case: parentCasePath .. childCasePath,
            destination: destination
        )
    }
}
