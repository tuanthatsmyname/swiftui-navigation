import Navigation
import SwiftUI

public struct MortgageFlow<MeetingFlow: View>: View {
    enum Destination {
        case detail
        case meeting
    }

    let factory: MortgageFactory<MeetingFlow>

    @State private var destination: Destination?

    public var body: some View {
        factory.makeMortgageView { action in
            switch action {
            case .detail:
                destination = .detail
            case .meeting:
                destination = .meeting
            }
        }
        .navigationDestination(unwrapping: $destination, case: /Destination.detail) { _ in
            factory.makeMortgageDetailView()
                .navigationTitle("Mortgage Detail")
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
