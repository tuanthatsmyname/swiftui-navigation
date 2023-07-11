import SwiftUI

struct LegacySecretView: View {
    @StateObject var viewModel: LegacySecretViewModel

    var body: some View {
        Button("Show me secret") {
            viewModel.onContinue()
        }
        .navigationTitle("Secret Intro")
    }
}

final class LegacySecretViewModel: ObservableObject {
    let onContinue: () -> Void

    init(onContinue: @escaping () -> Void) {
        self.onContinue = onContinue
    }

    deinit {
        print("Yahooo")
    }
}
