import SwiftUI

struct LoginView: View {
    var onSuccessfullLogin: () -> Void

    var body: some View {
        VStack {
            Button("Login") {
                onSuccessfullLogin()
            }
        }
    }
}
