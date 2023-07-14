import SwiftUI
import SwiftUINavigation

struct RootFlow: View {
    // TODO: AppStart can be separated from Root
    enum RootState {
        case dashboard
        case login
        case activation
        case appStart
        case secret
        case legacy
    }

    @State private var state: RootState = .appStart

    var body: some View {
        Switch($state) {
            CaseLet(/RootState.appStart) { _ in
                NavigationStack {
                    AppStartView(
                        onAppLoaded: {
                            state = .login
                        }
                    )
                }
            }

            CaseLet(/RootState.activation) { _ in
                NavigationStack {
                    ActivationFlow(
                        onSuccessfullActivation: {
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
                    .navigationTitle("Secret")
                }
            }

            CaseLet(/RootState.legacy) { _ in
                NavigationView {
                    LegacySecretFlow(
                        onSecretNoMore: {
                            state = .dashboard
                        }
                    )
                    .navigationTitle("Legacy")
                }
            }
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

