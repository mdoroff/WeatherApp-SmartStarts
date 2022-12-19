//
//  FiveDayForecastView.swift
//  Template
//
//  Created by Doroff, Mike on 12/15/22.
//

import SwiftUI

extension String {
    
    func convertToDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = inputFormatter.date(from: self) else { return inputFormatter.string(from: Date())}
        inputFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = inputFormatter.string(from: date)
        return formattedDate
    }
}

struct ForecastView: View {
    @ObservedObject var viewModel: ForecastViewModel
    @State var selection = 0
    @State var search = ""
    var body: some View {
        NavigationView {
            VStack {
                Text(search)
                    .font(.system(size: 24))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                
                if viewModel.forecast.dailyForecasts.isEmpty {
                    Text("Try searching for a location.")
                    
                } else {
                    List {
                        ForEach(viewModel.forecast.dailyForecasts, id: \.self) { dailyForecast in
                            
                            HStack(alignment: .top) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(dailyForecast.date.convertToDate())
                                        Text("Day: \(dailyForecast.day.iconPhrase)")
                                        Text("Night: \(dailyForecast.night.iconPhrase)")
                                    }
                                    Spacer()
                                    HStack {
                                        HStack {
                                            VStack {
                                                Text("High")
                                                Text("Low")
                                            }
                                        }
                                        HStack {
                                            VStack {
                                                Text("\(String(dailyForecast.temperature.maximum.value)) \u{00B0}\(dailyForecast.temperature.maximum.unit)")
                                                Text("\(String(dailyForecast.temperature.minimum.value)) \u{00B0}\(dailyForecast.temperature.minimum.unit)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Forecast")
            .searchable(text: $search, prompt: "Find Temperature for City")
            
            .onSubmit(of: .search) {
                
                viewModel.makeRequestToGetIntergerLocation(searchTerm: $search.wrappedValue) { locationKey in
                    
                    guard let convertLocationToInteger = Int(locationKey) else { return }
                    
                    viewModel.fetchFiveDayForecast(location: convertLocationToInteger)
                    
                }
                
            }
            
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: ForecastViewModel())
    }
}
