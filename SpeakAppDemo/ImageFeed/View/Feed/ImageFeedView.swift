//
//  ImageFeedView.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import SwiftUI

struct ImageFeedView: View {
  @ObservedObject private var viewModel: ImageFeedViewModel
  @State private var query: String = ""

  init(viewModel: ImageFeedViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter text", text: $query, onCommit: {
          viewModel.fetchQuery(query)
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()

        List(viewModel.feedData, id: \.firstImage.id) { cellData in
          NavigationLink(destination: ImageDetailView(viewModel: viewModel.makeImageDetailViewModel(for: cellData))) {
            HStack(alignment: .top) {
              VStack {
                FeedImageView(image: cellData.firstImage).onAppear {
                  viewModel.onAppear(image: cellData.firstImage)
                }
                Text(cellData.firstImage.tags)
              }
              VStack {
                FeedImageView(image: cellData.secondImage).onAppear {
                  viewModel.onAppear(image: cellData.secondImage)
                }
                Text(cellData.secondImage.tags)
              }
            }
          }
        }
        .navigationTitle("Image Search")
      }
    }
  }
}
