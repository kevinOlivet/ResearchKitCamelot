//
//  ConsentTask.swift
//  Camelot
//
//  Created by Jon Olivet on 8/22/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import ResearchKit

public var ConsentTask: ORKOrderedTask {
  
  var steps = [ORKStep]()
  
  //MARK: - VisualConsentStep
  
  let consentDocument = ConsentDocument
  let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
  steps += [visualConsentStep]
  
  //MARK: - ConsentReviewStep
  
  let signature = consentDocument.signatures!.first!
  
  let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
  
  reviewConsentStep.text = "Review Consent!"
  reviewConsentStep.reasonForConsent = "Consent to join study"
  
  steps += [reviewConsentStep]
  
  return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
