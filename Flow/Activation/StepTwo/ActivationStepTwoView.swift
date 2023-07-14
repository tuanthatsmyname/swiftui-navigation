import SwiftUI

struct ActivationStepTwoView: View {
    enum ViewState {
        case loading
        case content
    }

    var onSuccessfullActivation: () -> Void

    @State private var state: ViewState = .content

    var body: some View {
        switch state {
        case .loading:
            ProgressView()
        case .content:
            Button("Finish activation") {
                state = .loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    onSuccessfullActivation()
                }
            }
        }
    }
}
