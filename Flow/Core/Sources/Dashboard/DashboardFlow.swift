import SwiftUI

public struct DashboardFlow: View {
    public enum Action {
        case logout
        case deactivate
    }

    private enum Destination {
    }

    @State private var destination: Destination?
    private let onAction: (Action) -> Void

    public init(onAction: @escaping (Action) -> Void) {
        self.onAction = onAction
    }

    public var body: some View {
        VStack(spacing: 20) {
            Button("Log out") {
                onAction(.logout)
            }

            Button("Deactivate") {
                onAction(.deactivate)
            }
        }
    }
}
