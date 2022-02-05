//
//  AnalyticsProvider.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

protocol AnalyticsProvider {
    func report(eventName: String, properties: [AnyHashable: Any], type: AnalyticsEventType)
}
