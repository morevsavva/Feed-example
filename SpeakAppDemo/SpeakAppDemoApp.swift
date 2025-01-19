//
//  SpeakAppDemoApp.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import SwiftUI

@main
struct SpeakAppDemoApp: App {
  let rootModule = RootModule()

  var body: some Scene {
    WindowGroup {
      ImageFeedView(viewModel: ImageFeedViewModel(queryFetcher: rootModule.queryFetcher,
                                                  imageLoader: rootModule.imageLoader))
    }
  }
}
