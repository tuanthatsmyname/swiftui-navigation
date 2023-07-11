import SwiftUI

struct SecretInfoView: View {
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
