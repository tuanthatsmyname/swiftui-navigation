import SwiftUI

public struct AppStartFlow: View {
    private let onFinished: () -> Void

    public init(onFinished: @escaping () -> Void) {
        self.onFinished = onFinished
    }

    public var body: some View {
        VStack(spacing: 15) {
            ProgressView()
            Text("App is loading...")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onFinished()
            }
        }
    }
}

struct AppStartFlow_Previews: PreviewProvider {
    static var previews: some View {
        AppStartFlow(onFinished: {})
    }
}
