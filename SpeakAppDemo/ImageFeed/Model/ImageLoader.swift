//
//  ImageLoader.swift
//  SpeakAppDemo
//
//  Created by Savva Morev on 19.01.2025.
//

import UIKit

protocol ImageLoader {
  func loadImage(url: String) async -> UIImage?
}
