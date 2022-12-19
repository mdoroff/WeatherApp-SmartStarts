import Foundation

class LaunchDetailContentViewModel: ViewModel, ObservableObject {
    private let launchDetail: LaunchDetail
    
    init(launchDetail: AssistedInject<LaunchDetail>) {
        self.launchDetail = launchDetail.get()
    }
    
    var missionName: String {
        guard let missionName = launchDetail.missionName else {
            return "Name Unavailable"
        }
        return missionName
    }
    
    var details: String {
        guard let details = launchDetail.details else {
            return "No details available"
        }
        
        return details
    }
    
    var launchDateSring: String {
        guard let date = launchDetail.launchDate else {
            return "--"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var rocketType: String {
        guard let rocketType = launchDetail.rocketType else {
            return "--"
        }
        return rocketType
    }
    
    var launchSite: String {
        guard let launchSite = launchDetail.launchSite else {
            return "--"
        }
        return launchSite
    }
}
