import SwiftUI

struct MortgageDetailMenuView: View {
    let onSelect: () -> Void

    var body: some View {
        Button("Select") {
            onSelect()
        }
    }
}

#Preview {
    MortgageDetailMenuView(onSelect: {})
}
