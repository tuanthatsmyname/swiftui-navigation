import SwiftUI

extension AdaptiveActivationFlow {
    struct FinishActivationView: View {
        let onSuccessfullActivation: (_ userID: String) -> Void

        var body: some View {
            VStack(spacing: 15) {
                ProgressView()
                Text("We are activating the app for you, please wait!")
            }
            .navigationTitle("Finish")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    onSuccessfullActivation("ABCD")
                }
            }
        }
    }
}
