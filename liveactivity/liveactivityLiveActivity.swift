//
//  liveactivityLiveActivity.swift
//  liveactivity
//
//  Created by Vansh Vidyarthy on 13/08/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct liveactivityLiveActivity: Widget {

    var body: some WidgetConfiguration {

        ActivityConfiguration(for: JourneyAttributes.self) { context in

            // MARK: - Lock Screen / Banner

            VStack(alignment: .leading, spacing: 12) {

                HStack(alignment: .firstTextBaseline) {

                    Text(context.attributes.journeyName)
                        .font(.headline)
                        .lineLimit(1)

                    Spacer()

                    Text("\(Int(context.state.progress * 100))%")
                        .font(.headline)
                        .fontWeight(.semibold)
                }

                Text(context.state.currentStepName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)

                ProgressView(
                    value: context.state.progress
                )
                .progressViewStyle(.linear)

                HStack {

                    Text(
                        "Step \(context.state.currentStep) of \(context.state.totalSteps)"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    Spacer()

                    let remainingSteps =
                        context.state.totalSteps - context.state.currentStep

                    Text(
                        remainingSteps == 0
                            ? "Complete"
                            : "\(remainingSteps) remaining"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            .padding()

        } dynamicIsland: { context in

            DynamicIsland {

                // MARK: - Expanded Leading

                DynamicIslandExpandedRegion(.leading) {

                    VStack(alignment: .leading, spacing: 2) {

                        Text("Step \(context.state.currentStep)")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("of \(context.state.totalSteps)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }

                // MARK: - Expanded Trailing

                DynamicIslandExpandedRegion(.trailing) {

                    Text(
                        "\(Int(context.state.progress * 100))%"
                    )
                    .font(.title3)
                    .fontWeight(.bold)
                }

                // MARK: - Expanded Center

                DynamicIslandExpandedRegion(.center) {

                    Text(context.attributes.journeyName)
                        .font(.headline)
                        .lineLimit(1)
                }

                // MARK: - Expanded Bottom

                DynamicIslandExpandedRegion(.bottom) {

                    VStack(alignment: .leading, spacing: 8) {

                        Text(context.state.currentStepName)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)

                        ProgressView(
                            value: context.state.progress
                        )
                        .progressViewStyle(.linear)
                    }
                }

            } compactLeading: {

                // MARK: - Compact Leading

                HStack(spacing: 4) {

                    Image(systemName: "checklist")
                        .font(.caption2)
                        .fontWeight(.semibold)

                    Text(
                        "\(context.state.currentStep)/\(context.state.totalSteps)"
                    )
                    .font(.caption)
                    .fontWeight(.semibold)
                }

            } compactTrailing: {

                // MARK: - Compact Trailing

                Text(
                    "\(Int(context.state.progress * 100))%"
                )
                .font(.caption)
                .fontWeight(.bold)

            } minimal: {

                // MARK: - Minimal

                ZStack {

                    Circle()
                        .stroke(
                            Color.secondary.opacity(0.3),
                            lineWidth: 2
                        )

                    Circle()
                        .trim(
                            from: 0,
                            to: context.state.progress
                        )
                        .stroke(
                            Color.primary,
                            style: StrokeStyle(
                                lineWidth: 2,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))

                    Text("\(context.state.currentStep)")
                        .font(.system(size: 9))
                        .fontWeight(.bold)
                }
                .frame(width: 24, height: 24)
            }
        }
    }
}
