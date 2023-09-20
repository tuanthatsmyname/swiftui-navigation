import Navigation
import SwiftUI

public struct DashboardFlow: View {
    public enum Action {
        case logout
        case deactivate
    }

    private enum Destination {
        case mortgage
        case meeting
    }

    let onAction: (Action) -> Void
    let factory: DashboardFactory

    @State private var destination: Destination?

    public var body: some View {
        factory.makeDashboardView {
            switch $0 {
            case .logout:
                onAction(.logout)
            case .deactivate:
                onAction(.deactivate)
            case .mortgage:
                destination = .mortgage
            case .meeting:
                destination = .meeting
            }
        }
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.meeting
        ) { _ in
            factory.makeMeetingFlow()
        }
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.mortgage
        ) { _ in
            factory.makeMortgageFlow()
        }
    }
}
