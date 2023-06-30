import SwiftUI
import SwiftUINavigation

struct RootFlow<Router: Routing>: View {
    enum RootState {
        case dashboard
        case login
        case activation
        case appStart
    }

    @ObservedObject var router: Router

    @State private var state: RootState = .login

    var body: some View {
        Switch($state) {
            CaseLet(/RootState.appStart) { _ in
                Text("AppStart")
            }

            CaseLet(/RootState.activation) { _ in
                ActivationFlow(
                    router: router,
                    onSuccessfullActivation: {
                        state = .dashboard
                        router.popToRoot()
                    }
                )
                .navigationTitle("Activation")
            }

            CaseLet(/RootState.login) { _ in
                LoginFlow(
                    onSuccessfullLogin: {
                        state = .dashboard
                    }
                )
                .navigationTitle("Login")
            }

            CaseLet(/RootState.dashboard) { _ in
                DashboardFlow(
                    onLogout: {
                        state = .login
                    },
                    onDeactivate: {
                        state = .activation
                    }
                )
                .navigationTitle("Dashboard")
            }
        }
    }
}

struct InformationView: View {
    var contactsTapped: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Information")
            Button("Contacts") {
                contactsTapped()
            }
        }
    }
}

struct ContactsView: View {
    var onCloseFlow: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Contacts")
            Button("Close flow") {
                onCloseFlow()
            }
        }
    }
}

struct InformationFlow: View {
    enum Destination {
        case contacts
    }

    var onClose: () -> Void

    @State private var destination: Destination?

    var body: some View {
        InformationView(
            contactsTapped: {
                destination = .contacts
            }
        )
        .navigationTitle("Information")
        .navigationDestination(unwrapping: $destination, case: /Destination.contacts) { _ in
            ContactsView(
                onCloseFlow: {
                    onClose()
                }
            )
        }
    }
}
