import SwiftUI
import SwiftUINavigation

struct LegacySecretFlow: View {
    enum Destination: Hashable {
        case info
        case finish
    }

    @State private var destination: Destination?
    var onSecretNoMore: () -> Void

    var body: some View {
        LegacySecretView(
            viewModel: LegacySecretViewModel(
                onContinue: {
                    destination = .info
                }
            )
        )
        .navigation(item: $destination) { destination in
            switch destination {
            case .info:
                SecretInfoView {
                    self.destination = .finish
                }
            case .finish:
                SecretFinishView {
                    onSecretNoMore()
                }
            }
        }
    }
}
