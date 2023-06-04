import SwiftUI

struct ActivationView: View {
    var onContinue: () -> Void

    var body: some View {
        Button("Continue") {
            onContinue()
        }
        .navigationTitle("Activation")
    }
}
