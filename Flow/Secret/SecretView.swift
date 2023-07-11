import SwiftUI

struct SecretView: View {
    @StateObject var viewModel: SecretViewModel

    var body: some View {
        Button("Show me secret") {
            viewModel.onContinue()
        }
        .navigationTitle("Secret Intro")
    }
}

final class SecretViewModel: ObservableObject {
    let onContinue: () -> Void

    init(onContinue: @escaping () -> Void) {
        self.onContinue = onContinue
    }

    deinit {
        print("Yahooo")
    }
}
