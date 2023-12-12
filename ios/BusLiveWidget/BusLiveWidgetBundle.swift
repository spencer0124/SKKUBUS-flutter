//
//  BusLiveWidgetBundle.swift
//  BusLiveWidget
//
//  Created by 조승용 on 2023/12/11.
//

import WidgetKit
import SwiftUI

@main
struct BusLiveWidgetBundle: WidgetBundle {
    var body: some Widget {
        BusLiveWidget()
        BusLiveWidgetLiveActivity()
    }
}
