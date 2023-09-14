import Foundation

final class LoginViewModel: ObservableObject {
    private let onSuccessfullLogin: () -> Void

    init(onSuccessfullLogin: @escaping () -> Void) {
        self.onSuccessfullLogin = onSuccessfullLogin
    }

    func loginTapped() {
        onSuccessfullLogin()
    }
}
