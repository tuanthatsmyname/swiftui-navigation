import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Button("Tap to Login") {
                viewModel.loginTapped()
            }
        }
    }
}
