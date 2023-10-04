import Foundation
import SwiftUI

public final class MortgageFactory<MeetingFlow: View> {
    private let meetingFactory: MeetingFactory

    public init(meetingFactory: MeetingFactory) {
        self.meetingFactory = meetingFactory
    }

    public func makeMortgageFlow() -> MortgageFlow<MeetingFlow> {
        MortgageFlow(factory: self)
    }
}

public extension MortgageFactory {
    struct MeetingFactory {
        var makeMeetingFlow: () -> MeetingFlow

        public init(makeMeetingFlow: @escaping () -> MeetingFlow) {
            self.makeMeetingFlow = makeMeetingFlow
        }
    }
}

extension MortgageFactory {
    func makeMeetingFlow() -> MeetingFlow {
        meetingFactory.makeMeetingFlow()
    }

    func makeMortgageView(
        onAction: @escaping (MortgageView.Action
    ) -> Void) -> some View {
        MortgageView(onAction: onAction)
    }

    func makeMortgageDetailView(
        onOpenMenu: @escaping () -> Void
    ) -> some View {
        MortgageDetailView(onOpenMenu: onOpenMenu)
    }

    func makeMortgageDetailMenuView(
        onSelect: @escaping () -> Void
    ) -> some View {
        MortgageDetailMenuView(onSelect: onSelect)
    }
}
