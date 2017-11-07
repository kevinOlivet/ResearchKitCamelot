//
//  MicrophoneTask.swift
//  Camelot
//
//  Created by Jon Olivet on 8/22/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import ResearchKit

public var MicrophoneTask: ORKOrderedTask {
  
  return ORKOrderedTask.audioTask(withIdentifier: "AudioTask", intendedUseDescription: "A sentence prompt will be given to you to read.", speechInstruction: "These are the last dying words of Joseph of Aramathea", shortSpeechInstruction: "The Holy Grail can be found in the Castle of Aaaaaaaaaaah", duration: 10, recordingSettings: nil, checkAudioLevel: false, options: [])
}
