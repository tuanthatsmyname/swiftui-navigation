import SwiftUI

struct LoginFlow: View {
    var onSuccessfullLogin: () -> Void

    var body: some View {
        LoginView(onSuccessfullLogin: onSuccessfullLogin)
    }
}
