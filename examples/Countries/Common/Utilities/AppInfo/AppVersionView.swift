//
//  SwiftUIView.swift
//
//
//  Created by Mark Wells on 11/11/22.
//

import SwiftUI

public struct AppVersionView: View {
    
    public init() {}
    
    public var body: some View {
        Text("App Version: \(AppInfo.versionString())")
    }
}

struct AppVersionView_Previews: PreviewProvider {
    static var previews: some View {
        AppVersionView()
    }
}
