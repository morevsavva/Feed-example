//
//  ServerResponse.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

struct ServerResponse: Codable {
  struct Image: Codable {
    let webformatURL: String
    let tags: String
    
    var imageResult: FeedImage {
      FeedImage(url: webformatURL, tags: tags)
    }
  }
  
  let total: Int
  let hits: [Image]
  
  static let empty: Self = ServerResponse(total: 0, hits: [])
}
