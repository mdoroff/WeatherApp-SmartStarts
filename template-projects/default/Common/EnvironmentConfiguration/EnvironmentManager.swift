//
//  EnvironmentManager.swift
//  URLSession-Example
//
//  Created by Vargese, Sangeetha on 11/2/22.
//

import Foundation

enum EnvironmentManagerErrors: Error {
    case noEnvironmentPlistFound(String)
    case noEnvironmentConfiguredForAPI(key: String)
    case invalidEnvironment(String)
    case invalidURLForAPI(key: String)
}

class EnvironmentManager {
    let apiKey: String
    let environmentFileName: String
    let userDefaults: UserDefaults
    let bundle: Bundle
    
    init(environmentFileName: String = "Environment", userDefaults: UserDefaults = .standard, bundle: Bundle = .main, defaultEnv: EnvironmentTypes, apiKey: String) {
        self.apiKey = apiKey
        self.environmentFileName = environmentFileName
        self.userDefaults = userDefaults
        self.bundle = bundle
        registerSettingsBundle(defaultEnv: defaultEnv)
    }
    
    func getCurrentlySelectedEnvironment() throws -> EnvironmentTypes {
        guard let environmentString = UserDefaults.standard.string(forKey: apiKey) else {
            throw EnvironmentManagerErrors.noEnvironmentConfiguredForAPI(key: apiKey)
        }
        guard let environment = EnvironmentTypes(rawValue: environmentString) else {
            throw EnvironmentManagerErrors.invalidEnvironment(environmentString)
        }
        
        return environment
    }
    
    func getHostUrl() throws -> URL {
        let currentEnvironment = try getCurrentlySelectedEnvironment()
        
        guard let path = bundle.path(forResource: environmentFileName, ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let environmentTypes = dict[apiKey] as?  [String: Any],
              let environmentDetails = environmentTypes[currentEnvironment.rawValue] as? [String: String]
        else {
            throw EnvironmentManagerErrors.noEnvironmentPlistFound("Environment.plist not found")
        }
        
        guard let baseUrl = URL(string: environmentDetails["baseURL"] ?? "") else {
            throw EnvironmentManagerErrors.invalidURLForAPI(key: apiKey)
        }
        return baseUrl
    }
    
    // MARK: - Private
    
    private func registerSettingsBundle(defaultEnv: EnvironmentTypes) {
        let appDefaults = [apiKey: defaultEnv.rawValue]
        userDefaults.register(defaults: appDefaults)
    }
}
