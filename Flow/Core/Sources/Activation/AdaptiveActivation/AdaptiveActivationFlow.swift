import Navigation
import SwiftUI

struct AdaptiveActivationFlow: View {
    private enum Destination {
        case verificationCode(VerificationCodeDestination?)

        enum VerificationCodeDestination {
            case confirm(ConfirmDestination?)

            enum ConfirmDestination {
                case finish
            }
        }
    }

    let onFinishedAdaptiveActivation: (_ userID: String) -> Void

    @State private var destination: Destination?

    var body: some View {
        SubmitUsernameView(
            onSubmittedUsername: {
                destination = .verificationCode(nil)
            }
        )
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.verificationCode
        ) { _ in
            SubmitVerificationCodeView(
                onSubmittedVerificationCode: {
                    destination = .verificationCode(.confirm(nil))
                }
            )
            .navigationDestination(
                unwrapping: $destination,
                childCase: /Destination.VerificationCodeDestination.confirm,
                parentCase: /Destination.verificationCode
            ) { _ in
                ConfirmView(
                    onConfirm: {
                        destination = .verificationCode(.confirm(.finish))
                    }
                )
                .navigationDestination(
                    unwrapping: $destination,
                    childCase: /Destination.VerificationCodeDestination.ConfirmDestination.finish,
                    parentCase: /Destination.verificationCode .. /Destination.VerificationCodeDestination.confirm,
                    destination: { _ in
                        FinishActivationView(
                            onSuccessfullActivation: { userID in
                                onFinishedAdaptiveActivation(userID)
                            }
                        )
                    }
                )
            }
        }
    }
}
