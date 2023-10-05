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
            // this is where the whole activation flow is started
            // and then device setup flow is shown after successfull activation
            // unfortunately we need to do this with finishedAdaptiveActivationFlowBuilder
            // because we cannot use .navigationDestination (check the previous commits)
            // .navigationDestination is created when the whole view is created
            // so when device setup flow was created with .navigationDestination
            // the flow is attached to the first view of the flow, not the last view
            // this is why with navigationDestination the flow was poppped and new flow was pushed
            // if we want continious navigation then all of this has to happen inside of the flow
            AdaptiveActivationFlow(
                onResetActivation: {
                    destination = nil
                },
                finishedAdaptiveActivationFlowBuilder: { userID in
                    DeviceSetupFlow(
                        userID: userID,
                        onFinishedDeviceSetup: onSuccessfullActivation
                    )
                }
            )
        }
    }
}
