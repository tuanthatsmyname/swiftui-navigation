import SwiftUI
import SwiftUINavigation

struct SecretFlow: View {
    enum Destination {
        case info(InfoDestination?)

        enum InfoDestination {
            case finish
        }
    }

    @State private var destination: Destination?
    var onSecretNoMore: () -> Void

    var body: some View {
        SecretView(
            viewModel: SecretViewModel(
                onContinue: {
                    destination = .info(nil)
                }
            )
        )
        .navigationDestination(unwrapping: $destination, case: /Destination.info(nil)) { infoDestination in
            SecretInfoView {
                destination = .info(.finish)
            }
//            .navigationDestination(unwrapping: $destination, case: /Destination.info(.finish)) { _ in
//                SecretFinishView {
//                    onSecretNoMore()
//                }
//            }
        }
    }
}

// TODO: this is not working
// both navigationDestination triggers navigation
