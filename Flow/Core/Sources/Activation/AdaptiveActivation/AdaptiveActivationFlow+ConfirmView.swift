import SwiftUI

extension AdaptiveActivationFlow {
    struct ConfirmView: View {
        let onConfirm: () -> Void
        let onResetActivation: () -> Void

        var body: some View {
            VStack(spacing: 20) {
                Button("Confirm") {
                    onConfirm()
                }

                Button("Reset Activation") {
                    onResetActivation()
                }
            }
            .navigationTitle("Confirmation")
        }
    }
}
