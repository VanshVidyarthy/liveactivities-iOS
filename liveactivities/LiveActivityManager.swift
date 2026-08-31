//
//  LiveActivityManager.swift
//  liveactivities
//
//  Created by Vansh Vidyarthy on 14/08/26.
//

import Foundation
import ActivityKit

final class LiveActivityManager {

    // MARK: - Start

    func start(
        journeyName: String,
        currentStep: Int,
        totalSteps: Int,
        stepName: String
    ) {

        let attributes = JourneyAttributes(
            journeyName: journeyName
        )

        let progress = Double(currentStep) / Double(totalSteps)

        let initialState = JourneyAttributes.ContentState(
            currentStep: currentStep,
            totalSteps: totalSteps,
            currentStepName: stepName,
            progress: progress
        )

        do {

            let activity = try Activity<JourneyAttributes>.request(
                attributes: attributes,
                content: .init(
                    state: initialState,
                    staleDate: nil
                )
            )

            print("🚀 Live Activity started: \(activity.id)")
            print("Active activities: \(Activity<JourneyAttributes>.activities.count)")
            print("Journey: \(journeyName)")
            print("Step: \(currentStep)/\(totalSteps)")
            print("Step name: \(stepName)")
            print("Progress: \(progress)")

        } catch {

            print("❌ Failed to start Live Activity: \(error)")
        }
    }

    // MARK: - Update

    func update(
        step: Int,
        totalSteps: Int,
        stepName: String
    ) {

        let activities = Activity<JourneyAttributes>.activities

        print("Found \(activities.count) active Live Activities")

        guard let activity = activities.first else {
            print("❌ No active Live Activity")
            return
        }

        let progress = Double(step) / Double(totalSteps)

        let updatedState = JourneyAttributes.ContentState(
            currentStep: step,
            totalSteps: totalSteps,
            currentStepName: stepName,
            progress: progress
        )

        Task {

            await activity.update(
                ActivityContent(
                    state: updatedState,
                    staleDate: nil
                )
            )

            print("✅ Live Activity updated")
            print("Step: \(step)/\(totalSteps)")
            print("Name: \(stepName)")
            print("Progress: \(progress)")
        }
    }

    // MARK: - End

    func end() {

        let activities = Activity<JourneyAttributes>.activities

        guard let activity = activities.first else {
            print("❌ No active Live Activity")
            return
        }

        Task {

            await activity.end(
                nil,
                dismissalPolicy: .default
            )

            print("🛑 Live Activity ended")
        }
    }
}
