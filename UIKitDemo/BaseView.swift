//
//  BaseView.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 01/07/2021.
//

import UIKit

class BaseView: UIView {
    
    private lazy var customSwitch: SCCustomSwitch = {
        let customSwitch = SCCustomSwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = onColor
        customSwitch.offTintColor = UIColor.white
        customSwitch.cornerRadius = customSwitch.bounds.height / 2
        customSwitch.thumbCornerRadius = customSwitch.thumbView.bounds.height / 2
        customSwitch.thumbOffTintColor = offColor
        customSwitch.thumbOnTintColor = onColor
        customSwitch.thumbBorderWidth = borderWidth
        customSwitch.thumbBorderColor = offColor
        customSwitch.borderWidth = borderWidth
        customSwitch.borderColor = offColor
        customSwitch.animationDuration = 0.25
        return customSwitch
    }()
    
    var offColor: UIColor = .black
    var onColor: UIColor = .yellow
    var borderWidth: CGFloat = 2 {
        didSet {
            customSwitch.thumbBorderWidth = borderWidth
            customSwitch.borderWidth = borderWidth
            setupConstraints()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(customSwitch)
        setupConstraints()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(customSwitch)
        setupConstraints()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = bounds.size.height / 2
        backgroundColor = .black
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                customSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
                customSwitch.centerXAnchor.constraint(equalTo: centerXAnchor),
                customSwitch.widthAnchor.constraint(equalToConstant: bounds.size.width - 2 * borderWidth),
                customSwitch.heightAnchor.constraint(equalToConstant: bounds.size.height - 2 * borderWidth)])
        }
}
