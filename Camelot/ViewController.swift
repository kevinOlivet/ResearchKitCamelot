//
//  ViewController.swift
//  Camelot
//
//  Created by Jon Olivet on 8/22/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController {

  @IBOutlet weak var authorizeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Actions
  @IBAction func consentTapped(sender: AnyObject) {
    let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
    taskViewController.delegate = self
    present(taskViewController, animated: true, completion: nil)
  }
  
  @IBAction func surveyTapped(sender: AnyObject) {
    let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
    taskViewController.delegate = self
    present(taskViewController, animated: true, completion: nil)
  }
  
  @IBAction func microphoneTapped(sender: AnyObject) {
    let taskViewController = ORKTaskViewController(task: MicrophoneTask, taskRun: nil)
    taskViewController.delegate = self
    taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] , isDirectory: true) as URL
    print("Here is the output Directory: \(String(describing: taskViewController.outputDirectory))")
    present(taskViewController, animated: true, completion: nil)
  }

  // HealthKit Implementation
  @IBAction func authorizeTapped(sender: AnyObject) {
    if HealthKitManager.healthKitStore.authorizationStatus(for: HealthKitManager.heartRateType) == .sharingAuthorized && HealthKitManager.healthKitStore.authorizationStatus(for: HealthKitManager.distanceWalkingRunningType) == .sharingAuthorized {
      let alertController = UIAlertController(title: "Status", message: "You're already authorized.", preferredStyle: .alert)
      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(cancel)
      present(alertController, animated: true, completion: nil)
    } else if HealthKitManager.healthKitStore.authorizationStatus(for: HealthKitManager.heartRateType) == .notDetermined || HealthKitManager.healthKitStore.authorizationStatus(for: HealthKitManager.distanceWalkingRunningType) == .notDetermined {
      HealthKitManager.authorizeHealthKit()
    } else {
      let alertController = UIAlertController (title: "Authorize HealthKit Data", message: "Go to Settings?", preferredStyle: .alert)
      let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
        guard UIApplication.shared.canOpenURL(settingsUrl) else { return }
        UIApplication.shared.openURL(settingsUrl)
      }
      alertController.addAction(settingsAction)
      let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
      alertController.addAction(cancelAction)
      
      present(alertController, animated: true, completion: nil)
    }
  }
  
  @IBAction func walkTapped(sender: AnyObject){
    let taskViewController = ORKTaskViewController(task: WalkTask, taskRun: nil)
    taskViewController.delegate = self
    taskViewController.outputDirectory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
    present(taskViewController, animated: true, completion: nil)
    HealthKitManager.startMockHeartData()
  }
  
  @IBAction func musicTapped(sender: AnyObject) {
    let taskViewController = ORKTaskViewController(task: MusicTask, taskRun: nil)
    taskViewController.delegate = self
    taskViewController.outputDirectory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
    present(taskViewController, animated: true, completion: nil)
    HealthKitManager.startMockHeartData()
  }
  
  func checkHealthKitStatus() -> Bool {
    if HealthKitManager.healthKitStore.authorizationStatus(for: HealthKitManager.heartRateType) == .sharingAuthorized && HealthKitManager.healthKitStore.authorizationStatus(for: HealthKitManager.distanceWalkingRunningType) == .sharingAuthorized {
      return true
    } else {
      return false
    }
  }
}

// MARK: - ORKTaskViewControllerDelegate

extension ViewController: ORKTaskViewControllerDelegate {
  
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    
    HealthKitManager.stopMockHeartData()
    
    if (taskViewController.task?.identifier == "MusicTask" && reason == .completed) {
      let clip = ResultParser.findClip(task: taskViewController.task)
      print("Here is the clip name: \(clip!.rawValue)")
      
      let heartURL = ResultParser.findMusicHeartFiles(result: taskViewController.result)
      if let heartURL = heartURL {
        do {
          let string = try NSString.init(contentsOf: heartURL, encoding: String.Encoding.utf8.rawValue)
          print("Here are Music Heart results \(string)")
        } catch {}
      }
    }
    
    if (taskViewController.task?.identifier == "WalkTask" && reason == .completed) {
      let heartURLs = ResultParser.findWalkHeartFiles(result: taskViewController.result)
      
      for url in heartURLs {
        do {
          let string = try NSString.init(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
          print("Here are the walkHeart results \(string)")
        } catch {}
      }
    }
    
    //Handle results with taskViewController.result
    print("Here is my result file location: \(taskViewController.result)")
    taskViewController.dismiss(animated: true, completion: nil)
  }
  
  func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
    if step.identifier == "music" {
      return MusicStepViewController(step: step)
    } else {
      return nil
    }
  }
}

