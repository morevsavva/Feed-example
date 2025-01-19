//
//  FeedImage.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import Foundation
import UIKit
import SwiftUI

@Observable
@MainActor
final class FeedImage: Identifiable {
  enum FeedImageState: Equatable {
    case initial
    case loading
    case failed
    case loaded(UIImage)
    
    var isLoaded: Bool {
      switch self {
      case .initial, .loading, .failed:
        return false
      case .loaded(_):
        return true
      }
    }
  }
  
  let url: String
  let tags: String
  let id: Int
  
  var state: FeedImageState = .initial
  
  nonisolated init(url: String, tags: String) {
    self.url = url
    self.tags = tags
    self.id = "\(url)\(tags)".hashValue
  }
}

struct FeedImageView: View {
  var image: FeedImage
  
  var body: some View {
    switch image.state {
    case .initial:
      Color.green
    case .loading:
      ProgressView()
    case .failed:
      Color.red
    case .loaded(let image):
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
    }
  }
}
