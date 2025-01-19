//
//  ImageDetailViewModel.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import Combine
import Foundation
import UIKit

@MainActor
class ImageDetailViewModel: ObservableObject {
  @Published var data: FeedCellData
  private let imageLoader: ImageLoader
  
  init(data: FeedCellData, imageLoader: ImageLoader) {
    self.data = data
    self.imageLoader = imageLoader
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
}
