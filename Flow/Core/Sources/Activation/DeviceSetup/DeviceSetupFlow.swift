import SwiftUI

struct DeviceSetupFlow: View {
    private enum Destination {

    }

    let userID: String
    let onFinishedDeviceSetup: () -> Void

    @State private var destination: Destination?

    var body: some View {
        Button("Finish") {
            onFinishedDeviceSetup()
        }
        .navigationTitle("Device Setup")
    }
}
