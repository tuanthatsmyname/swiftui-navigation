import SwiftUI

extension AdaptiveActivationFlow {
    struct ConfirmView: View {
        let onConfirm: () -> Void

        var body: some View {
            Button("Confirm") {
                onConfirm()
            }
            .navigationTitle("Confirmation")
        }
    }
}
