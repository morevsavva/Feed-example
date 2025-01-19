//
//  ImageDetailView.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import SwiftUI

struct ImageDetailView: View {
  @ObservedObject private var viewModel: ImageDetailViewModel
  
  init(viewModel: ImageDetailViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    TabView {
      VStack {
        FeedImageView(image: viewModel.data.firstImage)
        Text(viewModel.data.firstImage.tags)
      }
      VStack {
        FeedImageView(image: viewModel.data.secondImage)
        Text(viewModel.data.secondImage.tags)
      }
    }
    .tabViewStyle(PageTabViewStyle())
  }
}
