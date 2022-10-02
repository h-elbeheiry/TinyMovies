//
//  MoviePosterCardView.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 9/30/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviePosterCardView: View {
    let movie: Movie

    var body: some View {
        ZStack {
            if let url = self.movie.posterURL {
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)

                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 204, height: 306)
    }
}
