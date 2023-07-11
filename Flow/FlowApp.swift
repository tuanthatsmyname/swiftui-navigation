import SwiftUI

@main
struct FlowApp: App {
//    @State private var path = NavigationPath()
//    @StateObject private var router = Router()

    var body: some Scene {
        WindowGroup {
            RootFlow()
        }
    }
}

protocol Routing: ObservableObject {

}

final class Router: Routing {
    @Published var navigationPath = NavigationPath()
}
