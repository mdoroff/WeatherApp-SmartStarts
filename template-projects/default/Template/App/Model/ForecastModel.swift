//
//  ForecastModel.swift
//  Template
//
//  Created by Doroff, Mike on 12/15/22.
//

import Foundation

struct ForecastModel: Codable {
    
    let dailyForecasts: [DailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct DailyForecast: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(uuid)
        hasher.combine(temperature)
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
    }
    
    let uuid = UUID()
    let date: String
    let temperature: Temperature
    let day: Day
    let night: Night
}

struct Day: Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case iconPhrase = "IconPhrase"
    }
    
    let iconPhrase: String
}
struct Night: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case iconPhrase = "IconPhrase"
    }
    
    let iconPhrase: String
}

struct Temperature: Codable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(maximum)
        hasher.combine(minimum)
    }
    enum CodingKeys: String, CodingKey {
        case maximum = "Maximum"
        case minimum = "Minimum"
    }
    let maximum: Maximum
    let minimum: Minimum
}

struct Maximum: Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
    let value: Int
    let unit: String
    let unitType: Int
}
struct Minimum: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
    let value: Int
    let unit: String
    let unitType: Int
}
