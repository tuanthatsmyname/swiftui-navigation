import SwiftUI

struct ActivationStepTwoView: View {
    var onSuccessfullActivation: () -> Void

    var body: some View {
        Button("Finish activation") {
            onSuccessfullActivation()
        }
        .navigationTitle("Step 2")
    }
}
