//
//  MusicClip.swift
//  Camelot
//
//  Created by Jon Olivet on 8/28/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation

enum MusicClip: String {
  case Chill3 = "chill_preview_3"
  case Chill4 = "chill_preview_4"
  case Dark4 = "dark_preview_4"
  case Happy1 = "happy_preview_1"
  case Light2 = "light_preview_2"
  case Light3 = "light_preview_3"
  
  static func random() -> MusicClip {
    switch arc4random_uniform(6) {
    case 0:
      return .Chill3
    case 1:
      return .Chill4
    case 2:
      return .Dark4
    case 3:
      return .Happy1
    case 4:
      return .Light2
    default:
      return .Light3
    }
  }
  
  func fileURL() -> URL {
    return URL(fileURLWithPath: Bundle.main.path(forResource: self.rawValue, ofType: "mp3")!)
  }
  
}
