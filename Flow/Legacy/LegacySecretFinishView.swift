import SwiftUI

struct LegacySecretFinishView: View {
    var onFinish: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Now you know")

            Button("Finis") {
                onFinish()
            }
        }
        .navigationTitle("Secret Completed")
    }
}
