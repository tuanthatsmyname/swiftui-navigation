import SwiftUI

struct MortgageView: View {
    enum Action {
        case meeting
        case detail
    }

    var onAction: (Action) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Button("Mortgage detail") {
                onAction(.detail)
            }

            Button("Arrange meeting") {
                onAction(.meeting)
            }
        }
    }
}

//#Preview {
//    MortgageView(onMeeting: {})
//}
