//
//  MovieDetailView.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 9/30/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @ObservedObject private var movieDetailState = MovieDetailViewModel()
    let movieId: Int

    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?

    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            HStack {
                Text(movie.genreText)
                Text("·")
                Text(movie.yearText)
                Text(movie.durationText)
            }

            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }

            Text("Starring").font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if movie.cast != nil && movie.cast!.count > 0 {
                        HStack(spacing: 8) {
                            ForEach(self.movie.cast!.prefix(9)) { cast in
                                VStack {
                                    WebImage(url: cast.profileURL)
                                        .resizable()
                                        .frame(width: 40, height: 60)
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(8)
                                    Text(cast.name)
                                }
                            }
                            Spacer()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                }
            }

            HStack(alignment: .top, spacing: 4) {
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Director(s)").font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }

                        if movie.producers != nil && movie.producers!.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }

                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            Text("Screenwriter(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct MovieDetailImage: View {
    let imageURL: URL

    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if let url = imageURL {
                WebImage(url: url)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
    }
}
