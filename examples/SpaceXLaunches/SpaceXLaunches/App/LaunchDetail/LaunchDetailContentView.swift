//
//  LaunchDetailContentView.swift
//  GraphQL-Example
//
//  Created by Jackson Booth on 6/15/22.
//

import SwiftUI

struct LaunchDetailContentView: View {
    @ObservedObject var viewModel: LaunchDetailContentViewModel
    
    var body: some View {
        List {
            HStack {
                Text("Launch site:")
                Text(viewModel.launchSite)
                Spacer()
            }
            HStack {
                Text("Launch date:")
                Text(viewModel.launchDateSring)
                Spacer()
            }
            VStack {
                HStack {
                    Text("More Details:")
                    Spacer()
                }
                .padding(.bottom, 8)
                Text(viewModel.details)
            }
        }
        .navigationTitle(viewModel.missionName)
    }
}
