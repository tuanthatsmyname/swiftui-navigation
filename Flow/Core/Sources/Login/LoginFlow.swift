import Foundation
import SwiftUI

public struct LoginFlow: View {
    private let onSuccessfullLogin: () -> Void

    public init(onSuccessfullLogin: @escaping () -> Void) {
        self.onSuccessfullLogin = onSuccessfullLogin
    }

    public var body: some View {
        LoginView(
            viewModel: LoginViewModel(onSuccessfullLogin: onSuccessfullLogin)
        )
    }
}
