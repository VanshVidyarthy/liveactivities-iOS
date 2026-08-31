//
//  NativeBridge.swift
//  liveactivities
//
//  Created by Vansh Vidyarthy on 17/08/26.
//

import Foundation
import WebKit

final class NativeBridge: NSObject, WKScriptMessageHandler {

    private let liveActivityManager = LiveActivityManager()

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {

        print("📱 Received message from Angular")
        print("Handler: \(message.name)")
        print("Body: \(message.body)")

        // Keep existing test bridge
        if message.name == "nativeBridge" {
            handleTestMessage(message.body)
            return
        }

        // Live Activity bridge
        if message.name == "liveActivity" {
            handleLiveActivityMessage(message.body)
            return
        }

        print("⚠️ Unknown message handler: \(message.name)")
    }

    // MARK: - Test Message

    private func handleTestMessage(_ body: Any) {

        guard let payload = body as? [String: Any] else {
            print("❌ Invalid test message")
            return
        }

        print("🧪 Test message received:")
        print(payload)
    }

    // MARK: - Live Activity

    private func handleLiveActivityMessage(_ body: Any) {

        guard let payload = body as? [String: Any] else {
            print("❌ Invalid Live Activity payload")
            return
        }

        guard let action = payload["action"] as? String else {
            print("❌ Live Activity payload has no action")
            return
        }

        print("🎯 Live Activity action: \(action)")

        switch action {

        case "start":
            handleStart(payload)

        case "update":
            handleUpdate(payload)

        case "end":
            handleEnd(payload)

        default:
            print("⚠️ Unknown Live Activity action: \(action)")
        }
    }

    // MARK: - Start

    private func handleStart(_ payload: [String: Any]) {

        guard
            let journeyId = payload["journeyId"] as? String,
            let journeyName = payload["journeyName"] as? String,
            let currentStep = payload["currentStep"] as? Int,
            let totalSteps = payload["totalSteps"] as? Int,
            let currentStepName = payload["currentStepName"] as? String
        else {
            print("❌ Invalid start payload")
            return
        }

        print("🚀 Starting Live Activity")
        print("Journey ID: \(journeyId)")
        print("Step: \(currentStep)/\(totalSteps)")
        print("Step name: \(currentStepName)")

        liveActivityManager.start(
            journeyName: journeyName,
            currentStep: currentStep,
            totalSteps: totalSteps,
            stepName: currentStepName
        )
    }

    // MARK: - Update

    private func handleUpdate(_ payload: [String: Any]) {

        guard
            let journeyId = payload["journeyId"] as? String,
            let journeyName = payload["journeyName"] as? String,
            let currentStep = payload["currentStep"] as? Int,
            let totalSteps = payload["totalSteps"] as? Int,
            let currentStepName = payload["currentStepName"] as? String
        else {
            print("❌ Invalid update payload")
            return
        }

        print("🔄 Updating Live Activity")
        print("Journey ID: \(journeyId)")
        print("Journey Name: \(journeyName)")
        print("Step: \(currentStep)/\(totalSteps)")
        print("Step name: \(currentStepName)")

        liveActivityManager.update(
            step: currentStep,
            totalSteps: totalSteps,
            stepName: currentStepName
        )
    }

    // MARK: - End

    private func handleEnd(_ payload: [String: Any]) {

        guard let journeyId = payload["journeyId"] as? String else {
            print("❌ Invalid end payload")
            return
        }

        print("🛑 Ending Live Activity")
        print("Journey ID: \(journeyId)")

        liveActivityManager.end()
    }
}
