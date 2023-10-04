import Chat
import Foundation
import Meeting
import Mortgage
import SwiftUI

public final class DashboardFactory {
    private typealias MeetingFactory = Meeting.MeetingFactory<Chat.ChatFlow>
    private typealias MortgageFactory = Mortgage.MortgageFactory<Meeting.MeetingFlow<Chat.ChatFlow>>

    private let chatFactory: ChatFactory
    private let meetingFactory: MeetingFactory
    private let mortgageFactory: MortgageFactory

    public init() {
        let chatFactory = ChatFactory()
        self.chatFactory = ChatFactory()
        let meetingFactory = MeetingFactory(
            chatFactory: .init(makeChatFlow: chatFactory.makeChatFlow)
        )
        self.meetingFactory = meetingFactory
        self.mortgageFactory = MortgageFactory(
            meetingFactory: .init(makeMeetingFlow: meetingFactory.makeMeetingFlow)
        )
    }

    public func makeDashboardFlow(
        onAction: @escaping (DashboardFlow.Action) -> Void
    ) -> DashboardFlow {
        DashboardFlow(onAction: onAction, factory: self)
    }
}

extension DashboardFactory {
    func makeDashboardView(
        onAction: @escaping (DashboardViewModel.Action) -> Void
    ) -> some View {
        DashboardView(
            viewModel: DashboardViewModel(onAction: onAction)
        )
    }

    func makeMortgageFlow() -> some View {
        mortgageFactory.makeMortgageFlow()
    }

    func makeMeetingFlow() -> some View {
        meetingFactory.makeMeetingFlow()
    }
}
