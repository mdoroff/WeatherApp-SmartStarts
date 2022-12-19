//
//  PlanetsListViewModel.swift
//  Planets
//
//  Created by Mark Wells on 11/29/22.
//

import Foundation
import Combine
import iOS_URLNetwork

class CountriesListViewModel: ObservableObject {

    @Published var countries: [Country] = []
    var cancellable: NetworkTask?
    var fetchMoreCancellable: AnyCancellable?
    @Published var nextURL: URL?

    // Why this? The API we are using has a governor limit for the free tier of 1 request per second.
    //  This combine CurrentValueSubject is a Publisher that we can inject values in over time (in
    //  our case whenever the user scrolls to show the Fetch More view or taps that button). The
    //  CurrentValueSubject permits us to set up a pipeline that throttles and deduplicates requests
    //  before sending the network request.
    let fetchMoreSubject = CurrentValueSubject<URL?, Never>(nil)

    init(cancellable: NetworkTask? = nil, nextURL: URL? = nil) {
        self.cancellable = cancellable
        self.nextURL = nextURL

        fetchMoreCancellable = fetchMoreSubject
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)  // tried .removeDuplicates() here but if a request failed it was never retried
            .sink(receiveCompletion: { completion in  // receiveCompletion may not be needed here - should live for lifetime of view model
                switch completion {
                case .finished:
                    print("Received finished")
                case .failure(let error):
                    print("Received error: \(error)")
                }
            }, receiveValue: { url in
                if let url = url {
                    self.performRequest(FetchCountries(fullURL: url))
                }
            })
    }

    fileprivate func performRequest(_ networkRequest: FetchCountries) {
        if cancellable == nil {
            cancellable = AppNetwork.shared.network.perform(request: networkRequest, completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print("service call failed with \(error)")
                    self.cancellable = nil
                case .success(let response):
                    print("response = \(response)")
                    self.countries.append(contentsOf: response.data)
                    self.nextURL = nil
                    if let links = response.links {
                        if let nextLink = links.filter({ $0.rel == "next" }).first {
                            if let next = URL(string: nextLink.href, relativeTo: EndPoints.global.baseApiUrl) {
                                self.nextURL = next
                            }
                        }
                    }
                    self.cancellable = nil
                }
            })
        }
    }

    func fetch() {
        self.countries = [Country]()
        performRequest(FetchCountries())
    }

    func fetchMore() {
        if let next = nextURL {
            self.fetchMoreSubject.send(next)
        }
    }

    func hasMore() -> Bool {
        return nextURL != nil
    }
}
