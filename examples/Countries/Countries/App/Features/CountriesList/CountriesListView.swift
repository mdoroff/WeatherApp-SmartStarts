//
//  PlanetsListView.swift
//  Planets
//
//  Created by Mark Wells on 11/29/22.
//

import SwiftUI

struct CustomToolbarModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .toolbarBackground(Color.cyan, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

extension View {
    func customToolbarStyle() -> some View {
        modifier(CustomToolbarModifier())
    }
}

struct CountriesListView: View {

    @ObservedObject var viewModel = CountriesListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.countries, id: \.id) { country in
                    NavigationLink(country.name, destination: CountryDetailView(country: country))
                }
                if viewModel.hasMore() {
                    Button("Fetch more...", action: {
                        viewModel.fetchMore()
                    })
                        .onAppear(perform: viewModel.fetchMore)
                }
            }
            .navigationTitle("Countries")
            .toolbar(content: {
                Button("Refresh List") {
                    viewModel.fetch()
                }
            })
            .customToolbarStyle()
        }
        .accentColor(.yellow)
        .onAppear(perform: viewModel.fetch)
    }
}
