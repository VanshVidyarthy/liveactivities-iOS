//
//  JourneyAttributes.swift.swift
//  liveactivities
//
//  Created by Vansh Vidyarthy on 14/08/26.
//
import ActivityKit
struct JourneyAttributes: ActivityAttributes {

    public struct ContentState: Codable, Hashable {
        var currentStep: Int
        var totalSteps: Int
        var currentStepName: String
        var progress: Double
    }

    var journeyName: String
}
