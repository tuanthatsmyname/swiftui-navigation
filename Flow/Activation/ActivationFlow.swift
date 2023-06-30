import SwiftUI
import SwiftUINavigation

struct ActivationFlow<Router: Routing>: View {
    enum Destination {
        case stepOne
    }

    @ObservedObject var router: Router
    var onSuccessfullActivation: () -> Void

    var body: some View {
        ActivationView(
            onContinue: {
                router.push(Destination.stepOne)
            }
        )
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .stepOne:
                ActivationStepOneFlow(
                    router: router,
                    onSuccessfullActivation: onSuccessfullActivation
                )
            }
        }
    }
}
