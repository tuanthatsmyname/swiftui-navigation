import Foundation
import SwiftUI

public final class MeetingFactory<ChatFlow: View> {
    private let chatFactory: ChatFactory

    public init(chatFactory: ChatFactory) {
        self.chatFactory = chatFactory
    }

    public func makeMeetingFlow() -> MeetingFlow<ChatFlow> {
        MeetingFlow(factory: self)
    }
}

public extension MeetingFactory {
    struct ChatFactory {
        var makeChatFlow: () -> ChatFlow

        public init(makeChatFlow: @escaping () -> ChatFlow) {
            self.makeChatFlow = makeChatFlow
        }
    }
}

extension MeetingFactory {
    func makeChatFlow() -> ChatFlow {
        chatFactory.makeChatFlow()
    }

    func makeMeetingView(onHelp: @escaping () -> Void) -> some View {
        MeetingView(onHelp: onHelp)
    }
}
