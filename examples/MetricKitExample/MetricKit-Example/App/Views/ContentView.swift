//
//  ContentView.swift
//  MetricKit-Example
//
//  Created by Prakash Khedekar, Harshad on 16/11/22.
//

import SwiftUI

struct ContentView: View {
    private var viewModel: ContentViewModel = .init()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.fruits, id: \.self) { item in
                    Text(item)
                        .padding()
                        .onTapGesture {
                            viewModel.rowTapped(fruit: item)
                        }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationBarTitle("Fruits", displayMode: .inline)
            .listStyle(PlainListStyle())
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
