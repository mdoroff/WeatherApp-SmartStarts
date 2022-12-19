//
//  FiveDayForecastViewModel.swift
//  Template
//
//  Created by Doroff, Mike on 12/15/22.
//

import Foundation
import iOS_URLNetwork

struct Location: Codable {
    let key: String
    enum CodingKeys: String, CodingKey {
        case key = "Key"
    }
}

class ForecastViewModel: ObservableObject {
    
    @Published var forecast: ForecastModel = ForecastModel(dailyForecasts: [])
    
    func makeRequestToGetIntergerLocation(searchTerm: String, closure: @escaping (String) -> Void) {
        
        let dispatchGroup = DispatchGroup()
    
        guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=OTkfNvM2VqgsPm7dbiNdza1cVGgdU4OD&q=\(searchTerm)") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        dispatchGroup.enter()
        let dataTask = URLSession(configuration: .default).dataTask(with: urlRequest) { data, _, err in
            if let err {
                print(err)
            }
            guard let data = data else { return }
            guard let locationData = try? JSONDecoder().decode([Location].self, from: data) else { return }
            guard let firstLocation = locationData.first else { return }
            closure(firstLocation.key)
            
            dispatchGroup.leave()
        }
        dataTask.resume()
    }

    func fetchFiveDayForecast(location: Int) {
        _ = AppNetwork.shared.network.perform(request: FetchForecasts(path: "/daily/5day/\(location)")) { [weak self] result in
            switch result {
            case .success(let data):
                self?.forecast = data
            case .failure(let error):
                print(error)
            }
        }
    }
}
