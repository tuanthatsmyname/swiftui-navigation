import SwiftUI
import SwiftUINavigation

struct RootFlow: View {
    enum RootState {
        case dashboard
        case login
        case activation
        case appStart
        case secret
        case legacy
    }

//    @ObservedObject var router: Router

    @State private var state: RootState = .login

    var body: some View {
        Switch($state) {
            CaseLet(/RootState.appStart) { _ in
                NavigationStack {
                    Text("AppStart")
                }
            }

            CaseLet(/RootState.activation) { _ in
                NavigationStack {
                    ActivationFlow(
                        onSuccessfullActivation: {
                            // this is the version without NavigationPath
                            // pros:
                            // - very similar to our current state
                            // - very simple
                            // - deeplinking should be easy
                            // - navigation is controlled by state
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

                            // there are some things we could do to prevent popping several levels of Views
                            // for example we can use sheets, to easily dismiss the whole Flow and then just changing the state of the parent View

                            // BUT! sometimes we really need to pop to the root view, for example if the user logs out, then we clear the whole navigation stack a show the login view
                            // and if we need to pop to the root view, we need to use NavigationPath
                            // and if we use NavigationPath, then everything has to be done with NavigationPath
                            // manually pushing screens do not add values to NavigationPath :(
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                state = .dashboard
//                            }
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Activation")
                }
            }

            CaseLet(/RootState.login) { _ in
                NavigationStack {
                    LoginFlow(
                        onSuccessfullLogin: {
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Login")
                }
            }

            CaseLet(/RootState.dashboard) { _ in
                NavigationStack {
                    DashboardFlow(
                        onLogout: {
                            state = .login
                        },
                        onDeactivate: {
                            state = .activation
                        },
                        onSecret: {
                            state = .secret
                        },
                        onLegacy: {
                            state = .legacy
                        }
                    )
                    .navigationTitle("Dashboard")
                }
            }

            CaseLet(/RootState.secret) { _ in
                NavigationStack {
                    SecretFlow(
                        onSecretNoMore: {
                            state = .dashboard
                        }
                    )
                }
            }

            CaseLet(/RootState.legacy) { _ in
                NavigationView {
                    LegacySecretFlow(
                        onSecretNoMore: {
                            state = .dashboard
                        }
                    )
                }
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

extension View {
    func navigation<Item, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: (Item) -> Destination?
    ) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }

    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination?
    ) -> some View {
        overlay(
            NavigationLink(
                isActive: isActive,
                destination: {
                    if isActive.wrappedValue {
                        destination()
                    }
                },
                label: { Text("") }
            )
            .accessibilityHidden(true)
            .opacity(0)
        )
    }
}

