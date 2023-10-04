import SwiftUI

struct MortgageDetailView: View {
    let onOpenMenu: () -> Void

    var body: some View {
        Button("Open Menu") {
            onOpenMenu()
        }
    }
}

#Preview {
    MortgageDetailView(onOpenMenu: {})
}
