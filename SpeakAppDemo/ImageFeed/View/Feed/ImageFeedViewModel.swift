//
//  ImageSearchViewModel.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import Combine
import Foundation
import UIKit

@MainActor
class ImageFeedViewModel: ObservableObject {
  @Published private(set) var feedData: [FeedCellData] = []
  private let queryFetcher: QueryFetcher
  private let imageLoader: ImageLoader
  
  init(queryFetcher: QueryFetcher, imageLoader: ImageLoader) {
    self.queryFetcher = queryFetcher
    self.imageLoader = imageLoader
  }
  
  func fetchQuery(_ query: String) {
    Task {
      let result = await queryFetcher.fetchQuery(query)
      await MainActor.run {
        feedData = result
      }
    }
  }
  
  func onAppear(image: FeedImage) {
    guard image.state != .loading, !image.state.isLoaded else { return }
    Task {
      await MainActor.run {
        image.state = .loading
      }
      let result = await imageLoader.loadImage(url: image.url)
      await MainActor.run {
        if let result {
          image.state = .loaded(result)
        } else {
          image.state = .failed
        }
      }
    }
  }
  
  func makeImageDetailViewModel(for cellData: FeedCellData) -> ImageDetailViewModel {
    return ImageDetailViewModel(data: cellData, imageLoader: imageLoader)
  }
}
