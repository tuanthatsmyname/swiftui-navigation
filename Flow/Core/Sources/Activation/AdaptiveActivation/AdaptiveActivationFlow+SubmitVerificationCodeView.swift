import SwiftUI

extension AdaptiveActivationFlow {
    struct SubmitVerificationCodeView: View {
        let onSubmittedVerificationCode: () -> Void

        var body: some View {
            Button("Verify Code") {
                onSubmittedVerificationCode()
            }
            .navigationTitle("Verification Code")
        }
    }
}
