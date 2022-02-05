//
//  AnalyticsServiceImpl.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

final class AnalyticsServiceImpl: AnalyticsService {
    private let queue: DispatchQueue
    private var providers: [AnalyticsProvider]
    private var eventTimeQueue: [String: Double]
    private var extraInformations: [AnyHashable: Any]

    init() {
        providers = [AnalyticsProvider]()
        extraInformations = [:]
        eventTimeQueue = [:]
        queue = DispatchQueue(label: "com.serialqueue.analytics.trackingtime")
    }
    
    func register(provider: AnalyticsProvider) {
        providers.append(provider)
    }
    
    func register(providers: [AnalyticsProvider]) {
        self.providers.append(contentsOf: providers)
    }
    
    func clearExtraInformations() {
        setExtraInformations(infos: [:])
    }
    
    func setExtraInformations(infos: [AnyHashable: Any]) {
        extraInformations = infos
    }
    
    func appendExtraInformations(infos: [AnyHashable: Any]) {
        extraInformations.merge(infos) { (_, new) in new }
    }
    
    func track(eventName: String, properties: [AnyHashable: Any] = [:]) {
        guard eventName.isNotEmpty else { return }
        report(eventName: eventName, properties: properties, type: .track)
    }
    
    func trackScreen(screenName: String) {
        guard screenName.isNotEmpty else { return }
        report(eventName: AnalyticsConstant.appViewScreen, properties: [
            AnalyticsConstant.screenName: screenName
        ], type: .track)
    }
    
    func trackClick(screenName: String, eventName: String) {
        guard screenName.isNotEmpty, eventName.isNotEmpty else { return }
        report(eventName: AnalyticsConstant.appClick, properties: [
            screenName: eventName
        ], type: .track)
    }
    
    func startTrack(screenName: String) {
        guard screenName.isNotEmpty else { return }
        queue.sync {
            eventTimeQueue[screenName] = Date().timeIntervalSince1970
            report(eventName: AnalyticsConstant.screenDuration, type: .startTrack)
        }
    }

    func endTrack(screenName: String, properties: [AnyHashable: Any] = [:]) {
        guard screenName.isNotEmpty else { return }
        queue.sync {
            guard let startTime = eventTimeQueue[screenName] else { return }
            eventTimeQueue.removeValue(forKey: screenName)
            
            let currentTime = Date().timeIntervalSince1970
            let duration = currentTime - startTime
            
            let mergedProps = properties.merging([
                AnalyticsConstant.duration: duration,
                AnalyticsConstant.screenName: screenName
            ]) { (_, new) in new }
            report(eventName: AnalyticsConstant.screenDuration, properties: mergedProps, type: .endTrack)
        }
    }
    
    func identify(name: String, properties: [AnyHashable: Any] = [:]) {
        guard name.isNotEmpty else { return }
        report(eventName: name, properties: properties, type: .identify)
    }
    
    func trackModel<T: Codable>(name: String, item: T) {
        guard let jsonData = try? JSONEncoder().encode(item) else { return }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData,
                                                                 options: .allowFragments) as? [AnyHashable: Any] else {
            return
        }
        report(eventName: name, properties: dictionary, type: .track)
    }
    
    private func report(eventName: String, properties: [AnyHashable: Any] = [:], type: AnalyticsEventType) {
        let mergedProps = properties.merging(extraInformations) { (old, _) in old }
        providers.forEach({
            $0.report(eventName: eventName, properties: mergedProps, type: type)
        })
    }
}
