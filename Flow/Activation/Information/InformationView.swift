import SwiftUI

struct InformationView: View {
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Information")
            Button("Close") {
                onClose()
            }
        }
    }
}
