//
//  MovieDetailViewModel.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 9/30/22.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    private let movieService: MovieService
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?

    init(movieService: MovieService = MovieConnection.shared) {
        self.movieService = movieService
    }

    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }

            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
