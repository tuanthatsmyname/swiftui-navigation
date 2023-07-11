import SwiftUI
import SwiftUINavigation

struct SecretFlow: View {
    enum Destination: Hashable {
        case info
        case finish
    }

    @State private var destination: Destination?
    var onSecretNoMore: () -> Void

    var body: some View {
        SecretView(
            viewModel: SecretViewModel(
                onContinue: {
                    destination = .info
                }
            )
        )
        .navigationDestination(unwrapping: $destination, case: /Destination.info) { _ in
            SecretInfoView {
                onSecretNoMore()
            }
        }
        .navigationDestination(unwrapping: $destination, case: /Destination.finish) { _ in
            SecretFinishView {
                onSecretNoMore()
            }
        }
//        .navigationDestination(for: Destination.self) { destination in
//            switch destination {
//            case .info:
//                SecretInfoView {
//                    self.destination = .finish
//                }
//            case .finish:
//                SecretFinishView {
//                    onSecretNoMore()
//                }
//            }
//        }
    }
}
