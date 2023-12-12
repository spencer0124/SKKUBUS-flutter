//
//  BusLiveWidgetLiveActivity.swift
//  BusLiveWidget
//
//  Created by 조승용 on 2023/12/11.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState // don't forget to add this line, otherwise, live activity will not display it.
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
    var id = UUID()
}

// Create shared default with custom group
let sharedDefault = UserDefaults(suiteName: "group.flutterioswidget1")!

struct BusLiveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
              // create your live activity widget extension here
              // to access Flutter properties:
            let myVariableFromFlutter = sharedDefault.string(forKey: "myVariableFromFlutter")!
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
//
//extension BusLiveWidgetAttributes {
//    fileprivate static var preview: BusLiveWidgetAttributes {
//        BusLiveWidgetAttributes(name: "World")
//    }
//}
//
//extension BusLiveWidgetAttributes.ContentState {
//    fileprivate static var smiley: BusLiveWidgetAttributes.ContentState {
//        BusLiveWidgetAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: BusLiveWidgetAttributes.ContentState {
//         BusLiveWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}
//
//#Preview("Notification", as: .content, using: BusLiveWidgetAttributes.preview) {
//   BusLiveWidgetLiveActivity()
//} contentStates: {
//    BusLiveWidgetAttributes.ContentState.smiley
//    BusLiveWidgetAttributes.ContentState.starEyes
//}
