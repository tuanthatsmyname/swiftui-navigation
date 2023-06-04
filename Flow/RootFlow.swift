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
                    onSuccessfullActivation: {
                        // this is the version without NavigationPath
                        // pros:
                        // - very similar to our current state
                        // - very simple
                        // cons:
                        // - different behavior of NavigationStack when changing the parent view
                        // - when changing the parent view, NavigationView popped all of the children that were no longer relevant
                        // - this is different with NavigationStack
                        // - looks like NavigationStack keeps the navigation stack a only changes the parent
                        // - we were used to chaning the whole stack by just changing the parent
                        // - that's why in this case ActivationFlow has to update the stack manually and remove all children
                        // the problem is that if we change the state in the parent to state = .dashboard
                        // then the parent forgets about the children, but they are stuck in the navigation stack and they do not pop
                        // we have to wait for the pop animation and then change the state to change to parent/root
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            state = .dashboard
                        }
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
