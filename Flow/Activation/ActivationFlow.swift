import SwiftUI
import SwiftUINavigation

struct ActivationFlow: View {
    enum Destination {
        case stepOne
    }

    var onSuccessfullActivation: () -> Void

    @State private var destination: Destination?

    var body: some View {
        ActivationView(
            onContinue: { destination = .stepOne }
        )
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.stepOne
        ) { _ in
            ActivationStepOneFlow(
                onSuccessfullActivation: {
                    destination = nil
                    onSuccessfullActivation()
                }
            )
        }
    }
}
