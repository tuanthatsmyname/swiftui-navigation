import Activation
import AppStart
import Dashboard
import Login
import SwiftUI
import SwiftUINavigation

public struct RootFlow: View {
    private enum State {
        case appStart
        case login
        case activation
        case dashboard
    }

    @SwiftUI.State private var state: State = .appStart

    public init() {}

    public var body: some View {
        Switch($state) {
            CaseLet(/State.appStart) { _ in
                NavigationStack {
                    AppStartFlow(
                        onFinished: {
                            state = .login
                        }
                    )
                }
            }

            CaseLet(/State.login) { _ in
                NavigationStack {
                    LoginFlow(
                        onSuccessfullLogin: {
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Login")
                }
            }

            CaseLet(/State.activation) { _ in
                NavigationStack {
                    ActivationFlow(
                        onSuccessfullActivation: {
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Activation Flow")
                }
            }

            CaseLet(/State.dashboard) { _ in
                NavigationStack {
                    DashboardFlow { action in
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
