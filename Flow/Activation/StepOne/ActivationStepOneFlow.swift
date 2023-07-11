import SwiftUI
import SwiftUINavigation

struct ActivationStepOneFlow: View {
    enum Destination {
        case stepTwo
        case modal
    }

    var onSuccessfullActivation: () -> Void

    @State private var destination: Destination?

    var body: some View {
        ActivationStepOneView(
            onContinue: {
                destination = .stepTwo
            },
            onModal: {
                destination = .modal
            }
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
        .sheet(unwrapping: $destination, case: /Destination.modal) { _ in
            Text("Modal")
                .navigationTitle("Modal")
        }
    }
}
