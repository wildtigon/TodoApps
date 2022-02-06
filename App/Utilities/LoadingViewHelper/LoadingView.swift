//
//  LoadingView.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import NVActivityIndicatorView

final class LoadingView: UIView {
    private lazy var indicatorContainer: UIStackView = {
        let indicatorContainer = UIStackView()
        indicatorContainer.axis = .vertical
        indicatorContainer.spacing = 8
        return indicatorContainer
    }()
    
    private lazy var lbMessage: UILabel = {
        let lbMessage = UILabel()
        lbMessage.textAlignment = .center
        lbMessage.font = currentConfig.messageFont
        lbMessage.textColor = currentConfig.indicatorColor
        return lbMessage
    }()
    
    private lazy var indicatorView: NVActivityIndicatorView = {
        let frame = CGRect(x: 0, y: 0,
                           width: currentConfig.indicatorSize,
                           height: currentConfig.indicatorSize)
        return NVActivityIndicatorView(frame: frame,
                                       type: .ballSpinFadeLoader,
                                       color: currentConfig.indicatorColor)
    }()
    
    private var currentConfig: Config = .default
    
    public var isLoading: Bool {
        indicatorView.isAnimating
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWidgets()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initWidgets() {
        addSubView(indicatorContainer, [
            equal(\.centerXAnchor),
            equal(\.centerYAnchor)
        ])
        
        indicatorContainer.addArrangedSubview(indicatorView)
        indicatorContainer.addArrangedSubview(lbMessage)
    }
    
    public func show(in parentView: UIView,
                     loadingMessage: String?,
                     allowsUserInteraction: Bool = false) {
        lbMessage.isHidden = loadingMessage.orEmpty.isEmpty
        lbMessage.text = loadingMessage
        indicatorView.startAnimating()
        
        parentView.isUserInteractionEnabled = allowsUserInteraction
        parentView.addSubView(self, [
            equal(\.centerXAnchor),
            equal(\.centerYAnchor)
        ])
    }
    
    public func hide() {
        indicatorView.stopAnimating()
        superview?.isUserInteractionEnabled = true
        self.removeFromSuperview()
    }
    
    public func set(config: Config) {
        currentConfig = config
        indicatorView.frame = CGRect(x: 0, y: 0,
                                     width: config.indicatorSize,
                                     height: config.indicatorSize)
        indicatorView.color = config.indicatorColor
        lbMessage.textColor = config.indicatorColor
        lbMessage.font = config.messageFont
    }
}

extension LoadingView {
    struct Config {
        let indicatorSize: CGFloat
        let indicatorColor: UIColor
        let messageFont: UIFont
        
        static let `default` = Config(indicatorSize: 38,
                                      indicatorColor: .gray,
                                      messageFont: .systemFont(ofSize: 12))
    }
}
