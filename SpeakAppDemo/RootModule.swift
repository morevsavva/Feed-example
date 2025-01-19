//
//  RootModule.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import Foundation

struct RootModule {
  let queryFetcher: QueryFetcher
  let imageLoader: ImageLoader
  
  private let urlSession = URLSession.shared
  
  init() {
    self.queryFetcher = FeedQueryFetcher(urlSession: urlSession)
    self.imageLoader = FeedImageLoader(urlSession: urlSession)
  }
}
