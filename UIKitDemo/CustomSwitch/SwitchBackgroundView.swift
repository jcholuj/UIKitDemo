//
//  SwitchBackgroundView.swift
//
//  Created by Jędrzej Chołuj on 06/07/2021.
//  Copyright © 2021 KISS digital. All rights reserved.
//

import UIKit
import SnapKit

final class SwitchBackgroundView: UIView {
    
    private let sportcamSwitch = CustomSwitch()
    private let contentView = UIView()
    private let width: CGFloat = 40
    private let height: CGFloat = 20
    private let switchBorderWidth: CGFloat = 2
    var customSwitch: CustomSwitch { sportcamSwitch }
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
        setupProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        snp.makeConstraints {
            $0.width.equalTo(width * 1.6)
            $0.height.equalTo(height * 1.6)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        
        sportcamSwitch.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(width - 2 * switchBorderWidth)
            $0.height.equalTo(height - 2 * switchBorderWidth)
        }
    }
    
    func setupHierarchy() {
        addSubview(contentView)
        addSubview(sportcamSwitch)
        bringSubviewToFront(sportcamSwitch)
    }
    
    func setupProperties() {
        setupSwitchViewProperties()
        setupCustomSwitchProperties()
        setupContentView()
    }
}

private extension SwitchBackgroundView {
    
    private func setupCustomSwitchProperties() {
        sportcamSwitch.translatesAutoresizingMaskIntoConstraints = false
        sportcamSwitch.onTintColor = .yellow
        sportcamSwitch.offTintColor = UIColor.white
        sportcamSwitch.layer.cornerRadius = height / 2
        sportcamSwitch.thumbOffTintColor = .black
        sportcamSwitch.thumbOnTintColor = .yellow
        sportcamSwitch.thumbBorderWidth = switchBorderWidth
        sportcamSwitch.thumbBorderColor = .black
        sportcamSwitch.animationDuration = 0.25
    }
    
    private func setupSwitchViewProperties() {
        backgroundColor = .clear
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = height / 2
        contentView.backgroundColor = .black
    }
}
