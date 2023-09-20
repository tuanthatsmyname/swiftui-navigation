import Foundation

final class DashboardViewModel: ObservableObject {
    enum Action {
        case logout
        case deactivate
        case mortgage
        case meeting
    }

    private let onAction: (Action) -> Void

    init(onAction: @escaping (Action) -> Void) {
        self.onAction = onAction
    }

    func openMortgageSelected() {
        onAction(.mortgage)
    }

    func openMeetingSelected() {
        onAction(.meeting)
    }

    func logoutSelected() {
        onAction(.logout)
    }

    func deactivateSelected() {
        onAction(.deactivate)
    }
}
