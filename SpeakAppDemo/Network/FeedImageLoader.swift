//
//  FeedImageLoader.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import UIKit

final class FeedImageLoader: ImageLoader {
  private let urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }
  
  func loadImage(url: String) async -> UIImage? {
    guard let url = URL(string: url) else {
      return nil
    }
    
    guard let (data, _) = try? await urlSession.data(from: url) else {
      return nil
    }
    
    guard let result = UIImage(data: data) else {
      return nil
    }
    return result
  }
}
