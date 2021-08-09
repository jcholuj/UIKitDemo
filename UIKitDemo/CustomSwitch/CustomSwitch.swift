//
//  CustomSwitch.swif
//
//  Created by Jędrzej Chołuj on 25/06/2021.
//  Copyright © 2021 KISS digital. All rights reserved.
//

import UIKit

class CustomSwitch: UIControl {
    
    var animationDuration: Double = 0.5
    private let thumbView = UIView(frame: CGRect.zero)
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    private var isAnimating = false
    
    var isOn: Bool = true {
        didSet { setupUI() }
    }
    
    var padding: CGFloat = 1 {
        didSet { layoutSubviews() }
    }
    
    var switchBorderWidth: CGFloat = 1 {
        didSet { setupUI() }
    }
    
    var thumbOnTintColor: UIColor = UIColor.white {
        didSet { setupUI() }
    }
    
    var thumbOffTintColor: UIColor = UIColor.black {
        didSet { setupUI() }
    }
    
    var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet { setupUI() }
    }
    
    var offTintColor: UIColor = UIColor.black {
        didSet { setupUI() }
    }
    
    var thumbSize: CGSize = CGSize.zero {
        didSet { layoutSubviews() }
    }
    
    var thumbBorderColor: UIColor = UIColor.black {
        didSet { setupUI() }
    }
    
    var thumbBorderWidth: CGFloat = 2 {
        didSet { setupUI() }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
}

extension CustomSwitch {
    fileprivate func setupUI() {
        clear()
        clipsToBounds = false
        thumbView.backgroundColor = isOn ? thumbOnTintColor : thumbOffTintColor
        thumbView.isUserInteractionEnabled = false
        thumbView.layer.borderWidth = thumbBorderWidth
        thumbView.layer.borderColor = thumbBorderColor.cgColor
        backgroundColor = isOn ? onTintColor : offTintColor
        addSubview(thumbView)
    }
    
    private func clear() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        animate()
        return true
    }
    
    func setOn(on: Bool, animated: Bool) {
        switch animated {
        case true:
            animate(on: on)
        case false:
            isOn = on
            setupViewsOnAction()
            completeAction()
        }
    }
    
    fileprivate func animate(on: Bool? = nil) {
        isOn = on ?? !isOn
        isAnimating = true
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
        }, completion: { _ in
            self.completeAction()
        })
    }
    
    private func setupViewsOnAction() {
        thumbView.frame.origin.x = isOn ? onPoint.x : offPoint.x
        backgroundColor = isOn ? onTintColor : offTintColor
    }

    private func completeAction() {
        isAnimating = false
        sendActions(for: UIControl.Event.valueChanged)
    }
}

extension CustomSwitch {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAnimating {
            layer.cornerRadius = bounds.size.height / 2
            backgroundColor = isOn ? onTintColor : offTintColor
            let thumbSize = thumbSize != CGSize.zero ? thumbSize : CGSize(width: bounds.size.height - 2, height: bounds.height - 2)
            let yPostition = (bounds.size.height - thumbSize.height * 1.6) / 2
            onPoint = CGPoint(x: bounds.size.width - thumbSize.width * 1.6 + 2 + switchBorderWidth, y: yPostition)
            offPoint = CGPoint(x: -switchBorderWidth - 2, y: yPostition)
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbView.frame.size.height *= 1.6
            thumbView.frame.size.width *= 1.6
            thumbView.layer.cornerRadius = thumbView.frame.height / 2
        }
    }
}
