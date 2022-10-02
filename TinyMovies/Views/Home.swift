//
//  Home.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 9/30/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject private var nowPlayingState = MovieViewModel()
    @ObservedObject private var topRatedState = MovieViewModel()
    @ObservedObject private var popularState = MovieViewModel()

    var body: some View {
        NavigationView {
            List {
                Group {
                    if popularState.movies != nil {
                        MoviePostersView(title: "Popular", movies: popularState.movies!)

                    } else {
                        LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))

                Group {
                    if nowPlayingState.movies != nil {
                        MovieBackDropView(title: "Now Playing", movies: nowPlayingState.movies!)

                    } else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))

                Group {
                    if topRatedState.movies != nil {
                        MovieBackDropView(title: "Top Rated", movies: topRatedState.movies!)

                    } else {
                        LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
            .navigationBarTitle("TinyMovies")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
    }
}
