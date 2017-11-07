//
//  WalkTask.swift
//  Camelot
//
//  Created by Jon Olivet on 8/28/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import ResearchKit

public var WalkTask: ORKOrderedTask {
  return ORKOrderedTask.fitnessCheck(withIdentifier: "WalkTask", intendedUseDescription: nil, walkDuration: 15 as TimeInterval, restDuration: 15 as TimeInterval, options: [])
}
