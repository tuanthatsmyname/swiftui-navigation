import SwiftUI

struct LegacySecretInfoView: View {
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Matrix is everywhere! 🙈")

            Button("OK...") {
                onContinue()
            }
        }
        .navigationTitle("Secret Info")
    }
}
