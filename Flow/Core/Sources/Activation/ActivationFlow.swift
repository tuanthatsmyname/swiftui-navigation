import Navigation
import SwiftUI

public struct ActivationFlow: View {
    private enum Destination {
        case adaptiveActivation(AdaptiveActivationDestination?)

        enum AdaptiveActivationDestination {
            case deviceSetup(_ userID: String)
        }
    }

    @State private var destination: Destination?
    private let onSuccessfullActivation: () -> Void

    public init(onSuccessfullActivation: @escaping () -> Void) {
        self.onSuccessfullActivation = onSuccessfullActivation
    }

    public var body: some View {
        ActivationInformationView(
            onStartActivation: {
                destination = .adaptiveActivation(nil)
            }
        )
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.adaptiveActivation
        ) { _ in
            AdaptiveActivationFlow(
                onFinishedAdaptiveActivation: { userID in
                    destination = .adaptiveActivation(.deviceSetup(userID))
                },
                onResetActivation: {
                    destination = nil
                }
            )
            .navigationDestination(
                unwrapping: $destination,
                childCase: /Destination.AdaptiveActivationDestination.deviceSetup,
                parentCase: /Destination.adaptiveActivation
            ) { userID in
                DeviceSetupFlow(
                    userID: userID.wrappedValue,
                    onFinishedDeviceSetup: onSuccessfullActivation
                )
            }
        }
    }
}
