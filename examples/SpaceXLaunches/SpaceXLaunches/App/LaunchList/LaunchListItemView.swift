//
//  LaunchListItemView.swift
//  GraphQL-Example
//
//  Created by Jackson Booth on 6/14/22.
//

import SwiftUI

struct LaunchListItemView: View {
    @ObservedObject var viewModel: LaunchListItemViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.missionName)
            Spacer()
            Text(viewModel.launchDateString)
        }
    }
}
