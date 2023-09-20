import SwiftUI

struct MeetingView: View {
    var onHelp: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Meeting")

            Button("Get help") {
                onHelp()
            }
        }
    }
}

//#Preview {
//    MeetingView(onHelp: {})
//}
