import SwiftUI

@main
struct FlowApp: App {
    @State private var path = NavigationPath()
    @StateObject private var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                RootFlow(router: router)
            }
        }
    }
}

protocol Routing: ObservableObject {

}

final class Router: Routing {
    @Published var navigationPath = NavigationPath()
}
