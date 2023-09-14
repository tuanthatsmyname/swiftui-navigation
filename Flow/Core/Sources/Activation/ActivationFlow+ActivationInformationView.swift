import SwiftUI

extension ActivationFlow {
    struct ActivationInformationView: View {
        let onStartActivation: () -> Void

        var body: some View {
            VStack(spacing: 15) {
                Text("Let's activate the freaking app!")
                Button("Start Activation") {
                    onStartActivation()
                }
            }
        }
    }
}
