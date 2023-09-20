import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel

    var body: some View {
        VStack(spacing: 20) {
            Button("Open Mortgage") {
                viewModel.openMortgageSelected()
            }

            Button("Open Meeting") {
                viewModel.openMeetingSelected()
            }

            Button("Log out") {
                viewModel.logoutSelected()
            }

            Button("Deactivate") {
                viewModel.deactivateSelected()
            }
        }
    }
}

#Preview {
    DashboardView(viewModel: .init(onAction: { _ in }))
}
