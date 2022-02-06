//
//  BaseViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

class BaseViewController<VM: ViewModelTransformable>: UIViewController {
    typealias Input = VM.Input
    
    let viewModel: VM
    let analyticsService: AnalyticsService?
    lazy var screenName: String = {"\(Self.self)"}()
    
    init(viewModel: VM, analyticsService: AnalyticsService? = nil, nibName: String? = nil) {
        self.viewModel = viewModel
        self.analyticsService = analyticsService
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("🚀 \(screenName) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService?.trackScreen(screenName: screenName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        analyticsService?.startTrack(screenName: screenName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analyticsService?.endTrack(screenName: screenName, properties: [:])
    }
}
