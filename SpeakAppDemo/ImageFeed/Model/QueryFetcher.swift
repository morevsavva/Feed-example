//
//  QueryFetcher.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

protocol QueryFetcher {
  func fetchQuery(_ query: String) async -> [FeedCellData]
}
