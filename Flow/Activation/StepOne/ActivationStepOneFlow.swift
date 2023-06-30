import SwiftUI
import SwiftUINavigation

struct ActivationStepOneFlow<Router: Routing>: View {
    enum Destination {
        case stepTwo
    }

    @ObservedObject var router: Router
    var onSuccessfullActivation: () -> Void

    var body: some View {
        ActivationStepOneView(
            onContinue: {
                router.push(Destination.stepTwo)
            }
        )
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .stepTwo:
                ActivationStepTwoView(onSuccessfullActivation: onSuccessfullActivation)
            }
        }
    }
}
