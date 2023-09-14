import SwiftUI

extension AdaptiveActivationFlow {
    struct SubmitUsernameView: View {
        let onSubmittedUsername: () -> Void

        var body: some View {
            Button("Submit Username") {
                onSubmittedUsername()
            }
            .navigationTitle("Submit Username")
        }
    }
}
