import SwiftUI
import AnalyticsKitCore

@main
class TemplateApp: App {
    required init() {
        // Configure your app's analytics, please see the documentation for more info - https://github.com/Deloitte/Apple-AnalyticsKit
        AnalyticsKit.register(global: AnalyticsKit(system: ConsoleLogAnalytics()))
    }
    
    var body: some Scene {
        WindowGroup {
            ForecastView(viewModel: ForecastViewModel())
                .onAppear {
                    // Example on how to send events
                    AKSendEvent(Events.contentViewAppeared)
            }
        }
    }
}
