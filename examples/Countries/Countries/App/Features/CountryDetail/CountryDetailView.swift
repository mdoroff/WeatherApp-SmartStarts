//
//  PlanetDetailView.swift
//  Planets
//
//  Created by Mark Wells on 12/2/22.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    let country: Country
    @State var countryRegion: MKCoordinateRegion?
    @State var region: MKCoordinateRegion = MKCoordinateRegion()

    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.bottom)
        }
        .customToolbarStyle()
        .navigationTitle(country.name)
        .toolbar(content: {
            Button("Reset") {
                resetVisibleMapRegion()
            }
        })

        .onAppear {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country.name
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, _) in
                guard let response = response else {
                    return
                }
                self.region = response.boundingRegion
                self.countryRegion = response.boundingRegion
            }
        }
    }

    func resetVisibleMapRegion() {
        if let unwrappedCountryRegion = countryRegion {
            region = unwrappedCountryRegion
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: Country(code: "ET", name: "Éthiopie", wikiDataId: "Q115"))
    }
}
