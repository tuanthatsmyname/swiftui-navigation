import SwiftUI

struct AppStartView: View {
    var onAppLoaded: () -> Void

    var body: some View {
        VStack(spacing: 5) {
            ProgressView()
            Text("App is loading...")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onAppLoaded()
            }
        }
    }
}

struct AppStartView_Previews: PreviewProvider {
    static var previews: some View {
        AppStartView(onAppLoaded: {})
    }
}
