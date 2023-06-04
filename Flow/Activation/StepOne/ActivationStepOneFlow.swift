import SwiftUI
import SwiftUINavigation

struct ActivationStepOneFlow: View {
    enum Destination {
        case stepTwo
    }

    var onSuccessfullActivation: () -> Void

    @State private var destination: Destination?

    var body: some View {
        ActivationStepOneView(
            onContinue: { destination = .stepTwo }
        )
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.stepTwo
        ) { _ in
            ActivationStepTwoView(
                onSuccessfullActivation: {
                    onSuccessfullActivation()
                }
            )
        }
    }
}
