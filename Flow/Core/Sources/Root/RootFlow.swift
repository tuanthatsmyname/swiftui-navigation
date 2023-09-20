import Activation
import AppStart
import Dashboard
import Login
import SwiftUI
import SwiftUINavigation

public struct RootFlow: View {
    private enum AppState {
        case start
        case login
        case activation
        case dashboard
    }

    @State private var state: AppState = .start
    private let dashboardFactory = DashboardFactory()

    public init() {}

    public var body: some View {
        Switch($state) {
            CaseLet(/AppState.start) { _ in
                NavigationStack {
                    AppStartFlow(
                        onFinished: {
                            state = .login
                        }
                    )
                }
            }

            CaseLet(/AppState.login) { _ in
                NavigationStack {
                    LoginFlow(
                        onSuccessfullLogin: {
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Login")
                }
            }

            CaseLet(/AppState.activation) { _ in
                NavigationStack {
                    ActivationFlow(
                        onSuccessfullActivation: {
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Activation Flow")
                }
            }

            CaseLet(/AppState.dashboard) { _ in
                NavigationStack {
                    dashboardFactory.makeDashboardFlow { action in
                        switch action {
                        case .logout:
                            state = .login
                        case .deactivate:
                            state = .activation
                        }
                    }
                    .navigationTitle("Dashboard")
                }
            }
        }
    }
}
