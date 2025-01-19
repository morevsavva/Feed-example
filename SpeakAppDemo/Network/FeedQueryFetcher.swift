//
//  FeedQueryFetcher.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import Foundation

final class FeedQueryFetcher: QueryFetcher {
  private let urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }
  
  func fetchQuery(_ query: String) async -> [FeedCellData] {
    guard !query.isEmpty else { return [] }
    let (queryURL, queryGraffitiURL) = makeURLs(from: query)
    
    async let queryResponse = fetch(from: queryURL).hits.prefix(10).map(\.imageResult)
    async let queryGraffitiResponse = fetch(from: queryGraffitiURL).hits.prefix(10).map(\.imageResult)
    
    return zip(await queryResponse, await queryGraffitiResponse).compactMap { FeedCellData(firstImage: $0.0, secondImage: $0.1) }
  }
  
  private func fetch(from urlString: String) async -> ServerResponse {
    guard let url = URL(string: urlString) else {
      return .empty
    }
    
    do {
      let (data, _) = try await urlSession.data(from: url)
      let imageResults = try JSONDecoder().decode(ServerResponse.self, from: data)
      return imageResults
    } catch {
      print("Ошибка получения или декодирования данных: \(error)")
      return .empty
    }
  }
}

private func makeURLs(from query: String) -> (String, String) {
  ("https://pixabay.com/api/?key=38738026-cb365c92113f40af7a864c24a&q=\(query)",
   "https://pixabay.com/api/?key=38738026-cb365c92113f40af7a864c24a&q=\(query)%20graffiti")
}
