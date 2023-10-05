import Navigation
import SwiftUI

struct AdaptiveActivationFlow<Flow: View>: View {
    private enum Destination {
        case verificationCode(VerificationCodeDestination?)

        enum VerificationCodeDestination {
            case confirm(ConfirmDestination?)

            enum ConfirmDestination {
                case finish(FinishDestination?)

                enum FinishDestination {
                    case deviceSetup(userID: String)
                }
            }
        }

        static var verificationCodeCasePath: CasePath<
            Destination,
            Destination.VerificationCodeDestination?
        > {
            /Destination.verificationCode
        }

        // TODO: eplore this option more
        static var confirmCasePath: CasePath<
            Destination.VerificationCodeDestination?,
            Destination.VerificationCodeDestination.ConfirmDestination?
        > {
            /Destination.VerificationCodeDestination.confirm
        }
    }

    let onResetActivation: () -> Void
    @ViewBuilder let finishedAdaptiveActivationFlowBuilder: (_ userID: String) -> Flow

    @State private var destination: Destination?

    var body: some View {
        SubmitUsernameView(
            onSubmittedUsername: {
                destination = .verificationCode(nil)
                // TODO: explore this more
//                destination = Destination.verificationCodeCasePath.embed(nil)
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
                        destination = .verificationCode(.confirm(.finish(nil)))
                    },
                    onResetActivation: {
                        onResetActivation()
                    }
                )
                .navigationDestination(
                    unwrapping: $destination,
                    childCase: /Destination.VerificationCodeDestination.ConfirmDestination.finish,
                    parentCase: (/Destination.verificationCode)
                        .appending(path: /Destination.VerificationCodeDestination.confirm)
                ) { _ in
                    FinishActivationView(
                        onSuccessfullActivation: { userID in
                            destination = .verificationCode(.confirm(.finish(.deviceSetup(userID: userID))))
                        }
                    )
                    .navigationDestination(
                        unwrapping: $destination,
                        childCase: /Destination.VerificationCodeDestination.ConfirmDestination.FinishDestination.deviceSetup,
                        parentCase: (/Destination.verificationCode)
                            .appending(path: /Destination.VerificationCodeDestination.confirm)
                            .appending(path: /Destination.VerificationCodeDestination.ConfirmDestination.finish)
                    ) { userID in
                        finishedAdaptiveActivationFlowBuilder(userID.wrappedValue)
                    }
                }
            }
        }
    }
}
