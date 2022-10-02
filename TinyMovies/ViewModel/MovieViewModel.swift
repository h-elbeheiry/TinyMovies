//
//  MovieViewModel.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 9/30/22.
//

import Foundation
import Combine
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let movieService: MovieService

    init(movieService: MovieService = MovieConnection.shared) {
        self.movieService = movieService
    }

    func loadMovies(with endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results

            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
