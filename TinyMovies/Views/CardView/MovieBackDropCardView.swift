//
//  MovieBackDropCardView.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 9/30/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieBackDropCardView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))

                if let url = self.movie.backdropURL {
                    WebImage(url: url)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)

            Text(movie.title)
        }
        .lineLimit(1)
    }
}
