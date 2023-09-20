import Navigation
import SwiftUI

public struct MeetingFlow<ChatFlow: View>: View {
    private enum Destination {
        case chat
    }

    let factory: MeetingFactory<ChatFlow>

    @State private var destination: Destination?

    public var body: some View {
        factory.makeMeetingView(
            onHelp: {
                destination = .chat
            }
        )
        .navigationTitle("Meeting")
        .sheet(unwrapping: $destination, case: /Destination.chat) { _ in
            NavigationStack {
                factory.makeChatFlow()
                    .navigationTitle("Chat")
            }
        }
    }
}
