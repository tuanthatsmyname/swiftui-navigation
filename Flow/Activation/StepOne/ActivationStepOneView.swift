import SwiftUI

struct ActivationStepOneView: View {
    var onContinue: () -> Void
    var onModal: () -> Void

    var body: some View {
        VStack {
            Button("Continue") {
                onContinue()
            }

            Button("Modal") {
                onModal()
            }
        }
        .navigationTitle("Step 1")
    }
}
