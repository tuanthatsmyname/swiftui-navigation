import SwiftUI

struct ActivationStepOneView: View {
    var onContinue: () -> Void

    var body: some View {
        Button("Continue") {
            onContinue()
        }
        .navigationTitle("Step 1")
    }
}
