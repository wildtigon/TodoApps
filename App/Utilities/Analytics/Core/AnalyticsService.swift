//
//  AnalyticsService.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

protocol AnalyticsService {
    func register(provider: AnalyticsProvider)
    func register(providers: [AnalyticsProvider])
    func clearExtraInformations()
    func setExtraInformations(infos: [AnyHashable: Any])
    func appendExtraInformations(infos: [AnyHashable: Any])
    func track(eventName: String, properties: [AnyHashable: Any])
    func trackScreen(screenName: String)
    func trackClick(screenName: String, eventName: String)
    func startTrack(screenName: String)
    func endTrack(screenName: String, properties: [AnyHashable: Any])
    func identify(name: String, properties: [AnyHashable: Any])
    func trackModel<T: Codable>(name: String, item: T)
}
