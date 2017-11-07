//
//  MusicTask.swift
//  Camelot
//
//  Created by Jon Olivet on 8/28/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import ResearchKit

public var MusicTask: ORKOrderedTask {
  
  var steps = [ORKStep]()
  
  let instructionStep = ORKInstructionStep(identifier: "instruction")
  instructionStep.title = "Music + Heart Rate"
  instructionStep.text = "Please listen to a radomized music clip for 30 seconds, and we'll record your heart rate."
  
  steps += [instructionStep]
  
  // Recorder configuration
  let configuration = ORKHealthQuantityTypeRecorderConfiguration(identifier: "heartRateConfig", healthQuantityType: HKQuantityType.quantityType(forIdentifier: .heartRate)!, unit: HKUnit(from: "count/min"))
  
  // Music Step
  let musicStep = MusicStep(identifier: "music")
  musicStep.clip = MusicClip.random()
  musicStep.stepDuration = 30
  musicStep.recorderConfigurations = [configuration]
  musicStep.shouldShowDefaultTimer = true
  musicStep.shouldStartTimerAutomatically = true
  musicStep.shouldContinueOnFinish = true
  musicStep.title = "Please listen for 30 seconds"
  
  steps += [musicStep]
  
  let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
  summaryStep.title = "Thank you!"
  summaryStep.text = "You have helped us research music and heart rate!"
  
  steps += [summaryStep]
  
  return ORKOrderedTask(identifier: "MusicTask", steps: steps)
}
