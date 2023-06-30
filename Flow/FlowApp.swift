import SwiftUI

//@main
//struct FlowApp: App {
//    @StateObject private var router = Router()
//
//    @State var path: [Int] = []
//
//    var body: some Scene {
//        WindowGroup {
////            NavigationStack(path: $router.navigationPath) {
////                RootFlow(router: router)
////            }
//            NavigationStack(path: $path) {
//                NextView {
//                    path.append(1)
//                }
//                .navigationDestination(for: Int.self) { _ in
//                    NextView {
//                        path = []
//                    }
//                }
//            }
//        }
//    }
//}

struct NextView: View {
    var onNext: () -> Void

    var body: some View {
        Button("Next") {
            onNext()
        }
    }
}

protocol Routing: ObservableObject {
    func push<Destination: Hashable>(_ destination: Destination)
    func pop()
    func popToRoot()
}

final class Router: Routing {
    @Published var navigationPath = NavigationPath()

    func push<Destination: Hashable>(_ destination: Destination) {
        navigationPath.append(destination)
    }

    func pop() {
        navigationPath.removeLast(1)
    }

    func popToRoot() {
//        navigationPath.removeLast(navigationPath.count)
        UINavigationBar.setAnimationsEnabled(false)
        navigationPath = .init()
        UINavigationBar.setAnimationsEnabled(true)
    }
}
