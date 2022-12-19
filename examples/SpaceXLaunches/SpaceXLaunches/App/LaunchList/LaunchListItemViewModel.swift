import Foundation

class LaunchListItemViewModel: ViewModel, ObservableObject {
    let launch: Launch
    
    init(launch: AssistedInject<Launch>) {
        self.launch = launch.get()
    }
    
    var missionName: String {
        return launch.missionName ?? "Error"
    }
    
    var launchDateString: String {
        guard let date = launch.launchDate else {
            return "Error"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
