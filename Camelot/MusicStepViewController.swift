//
//  MusicStepViewController.swift
//  Camelot
//
//  Created by Jon Olivet on 8/28/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import AVFoundation
import ResearchKit

class MusicStepViewController: ORKActiveStepViewController {

  var audioPlayer: AVAudioPlayer?
  
  override func start() {
    super.start()
    
    if let step = step as? MusicStep {
      do {
        try audioPlayer = AVAudioPlayer(contentsOf: step.clip.fileURL(), fileTypeHint: AVFileTypeMPEGLayer3)
        audioPlayer?.play()
      } catch {}
    }
  }
  
  override func stepDidFinish() {
    super.stepDidFinish()
    audioPlayer?.stop()
  }
  
}
