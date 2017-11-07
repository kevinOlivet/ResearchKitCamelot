//
//  HealthKitManager.swift
//  Camelot
//
//  Created by Jon Olivet on 8/28/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager: NSObject {
  
  static let healthKitStore = HKHealthStore()
  static var timer: Timer?
  static let heartRateType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
  static let distanceWalkingRunningType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
  
  static func authorizeHealthKit() {
    
    let healthKitTypes: Set = [
      heartRateType,
      distanceWalkingRunningType
    ]
    
    healthKitStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
      if !success {
        print(error!)
      }
    }
  }
  
  // Mocking Heart Data! Don't test on a read device!
  static func saveMockHeartData() {
    // Create a heart rate BPM Sample
    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let heartRateQuantity = HKQuantity(unit: HKUnit(from: "count/min"), doubleValue: Double(arc4random_uniform(80) + 100))
    let heartSample = HKQuantitySample(type: heartRateType, quantity: heartRateQuantity, start: NSDate() as Date, end: NSDate() as Date)
    
    // Save the sample in the store
    healthKitStore.save(heartSample) { (success, error) in
      if let error = error {
        print("Error saving heart sample: \(error.localizedDescription)")
      }
    }
  }
  
  static func startMockHeartData(){
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(HealthKitManager.saveMockHeartData), userInfo: nil, repeats: true)
  }
  
  static func stopMockHeartData() {
    self.timer?.invalidate()
  }
}
