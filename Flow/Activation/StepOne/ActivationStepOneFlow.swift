import SwiftUI
import SwiftUINavigation

struct ActivationStepOneFlow: View {
    enum Destination {
        case stepTwo
        case information
    }

    var onSuccessfullActivation: () -> Void

    @State private var destination: Destination?

    var body: some View {
        ActivationStepOneView(
            onContinue: {
                destination = .stepTwo
            },
            onInformation: {
                destination = .information
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
            .navigationTitle("Step 2")
        }
        .sheet(
            unwrapping: $destination,
            case: /Destination.information
        ) { _ in
            InformationView(
                onClose: {
                    destination = nil
                }
            )
        }
    }
}
