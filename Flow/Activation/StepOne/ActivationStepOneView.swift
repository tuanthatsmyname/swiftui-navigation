import SwiftUI

struct ActivationStepOneView: View {
    var onContinue: () -> Void
    var onInformation: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Button("Continue") {
                onContinue()
            }

            Button("Info") {
                onInformation()
            }
        }
        .navigationTitle("Step 1")
    }
}
