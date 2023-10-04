import Navigation
import SwiftUI

public struct MortgageFlow<MeetingFlow: View>: View {
    enum Destination {
        case detail(DetailDestination?)
        case meeting

        enum DetailDestination {
            case menu
            case selection
        }
    }

    let factory: MortgageFactory<MeetingFlow>

    @State private var destination: Destination?

    public var body: some View {
        factory.makeMortgageView { action in
            switch action {
            case .detail:
                destination = .detail(nil)
            case .meeting:
                destination = .meeting
            }
        }
        .navigationTitle("Mortgage")
        .navigationDestination(
            unwrapping: $destination,
            case: /Destination.detail
        ) { _ in
            factory.makeMortgageDetailView(
                onOpenMenu: {
                    destination = .detail(.menu)
                }
            )
            .navigationTitle("Mortgage Detail")
            .resizableSheet(
                unwrapping: $destination,
                childCase: /Destination.DetailDestination.menu,
                parentCase: /Destination.detail,
                content: { _ in
//                    NavigationStack {
                        factory.makeMortgageDetailMenuView(
                            onSelect: {
                                destination = .detail(nil)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    destination = .detail(.selection)
                                }
                            }
                        )
//                        .navigationTitle("Menu")
//                    }
                }
            )
            .navigationDestination(
                unwrapping: $destination,
                childCase: /Destination.DetailDestination.selection,
                parentCase: /Destination.detail
            ) { _ in
                Text("Selection")
            }
        }
        .sheet(unwrapping: $destination, case: /Destination.meeting) { _ in
            NavigationStack {
                factory.makeMeetingFlow()
                    .navigationTitle("Meeting")
            }
        }
    }
}

//#Preview {
//    MortgageFlow()
//}
