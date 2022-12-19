//
//  File.swift
//
//
//  Created by Mark Wells on 11/11/22.
//

import Foundation

public class AppInfo {
    
    /// Returns the app bundle version string with the git commit hash appended if available in the Info.plist file under the key REVISION.
    public static func versionString() -> String {
        guard let bundleVersionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return ""
        }
        #if !PROD
        if let revision = Bundle.main.object(forInfoDictionaryKey: "REVISION") as? String {
            return "\(bundleVersionString) (\(revision))"
        }
        #endif
        return bundleVersionString
    }
}
