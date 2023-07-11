import SwiftUI
import SwiftUINavigation

struct DashboardFlow: View {
    enum Destination {
        case legacy
    }

    var onLogout: () -> Void
    var onDeactivate: () -> Void
    var onSecret: () -> Void
    var onLegacy: () -> Void

    @State private var destination: Destination?

    var body: some View {
        VStack(spacing: 20) {
            Button("Log out") {
                onLogout()
            }

            Button("Deactivate") {
                onDeactivate()
            }

            Button("Secret") {
                onSecret()
            }

            Button("Legacy") {
                onLegacy()
//                destination = .legacy
            }
        }
//        .navigationDestination(unwrapping: $destination, case: /Destination.legacy) { _ in
//            NavigationView {
//                LegacySecretFlow(
//                    onSecretNoMore: {
//                        destination = nil
//                    }
//                )
//            }
//        }
    }
}
