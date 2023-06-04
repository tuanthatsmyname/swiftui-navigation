import SwiftUI

struct DashboardFlow: View {
    var onLogout: () -> Void
    var onDeactivate: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Button("Log out") {
                onLogout()
            }

            Button("Deactivate") {
                onDeactivate()
            }
        }
    }
}
