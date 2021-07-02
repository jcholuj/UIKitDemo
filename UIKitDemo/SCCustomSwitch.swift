//
//  SCCustomSwitch.swift
//  RankedIn
//
//  Created by Jędrzej Chołuj on 25/06/2021.
//  Copyright © 2021 KISS digital. All rights reserved.
//

import UIKit

class SCCustomSwitch: UIControl {
    
    // MARK: Public properties
    var animationDelay: Double = 0
    var animationSpriteWithDamping = CGFloat(0.7)
    var initialSpringVelocity = CGFloat(0.5)
    var animationOptions: UIView.AnimationOptions = [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction]
    
    var isOn: Bool = true {
        didSet { thumbView.backgroundColor = isOn ? thumbOnTintColor : thumbOffTintColor }
    }
    
    var animationDuration: Double = 0.5
    
    var padding: CGFloat = 1 {
        didSet { layoutSubviews() }
    }
    
    var borderColor: UIColor = UIColor.black {
        didSet { setupUI() }
    }
    
    var borderWidth: CGFloat = 1 {
        didSet { setupUI() }
    }
    
    var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet { setupUI() }
    }
    
    var offTintColor: UIColor = UIColor.black {
        didSet { setupUI() }
    }
    
    var cornerRadius: CGFloat {
        get { return self.privateCornerRadius }
        set { privateCornerRadius = newValue > 0.5 || newValue < 0.0 ? 0.5 : newValue }
        
    }
    
    private var privateCornerRadius: CGFloat = 0.5 {
        didSet { layoutSubviews() }
    }
    
    // thumb properties
    var thumbOnTintColor: UIColor = UIColor.white
    var thumbOffTintColor: UIColor = UIColor.black
    
    var thumbCornerRadius: CGFloat {
        get { return privateThumbCornerRadius }
        set { privateThumbCornerRadius = newValue > 0.5 || newValue < 0.0 ? 0.5 : newValue }
        
    }
    
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet { layoutSubviews() }
    }
    
    var thumbSize: CGSize = CGSize.zero {
        didSet { layoutSubviews() }
    }
    
    var thumbImage: UIImage? = nil {
        didSet {
            guard let image = thumbImage else { return }
            thumbView.thumbImageView.image = image
        }
    }
    
    public var onImage: UIImage? {
        didSet {
            onImageView.image = onImage
            layoutSubviews()
            
        }
        
    }
    
    public var offImage: UIImage? {
        didSet {
            offImageView.image = offImage
            layoutSubviews()
        }
        
    }
    
    
    // dodati kasnije
    var thumbBorderColor: UIColor = UIColor.black {
        didSet { thumbView.layer.borderColor = thumbBorderColor.cgColor }
    }
    
    var thumbBorderWidth: CGFloat = 1 {
        didSet { thumbView.layer.borderWidth = thumbBorderWidth }
    }
    
    var thumbShadowColor: UIColor = UIColor.black {
        didSet { thumbView.layer.shadowColor = thumbShadowColor.cgColor }
    }
    
    var thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2) {
        didSet { thumbView.layer.shadowOffset = thumbShadowOffset }
    }
    
    var thumbShaddowRadius: CGFloat = 1.5 {
        didSet { thumbView.layer.shadowRadius = thumbShaddowRadius }
    }
    
    var thumbShaddowOppacity: Float = 0.4 {
        didSet { thumbView.layer.shadowOpacity = thumbShaddowOppacity }
    }
    
    // labels
    
    var labelOff: UILabel = UILabel()
    var labelOn: UILabel = UILabel()
    
    var areLabelsShown: Bool = false {
        didSet { setupUI() }
    }
    
    var thumbView = SCCustomThumbView(frame: CGRect.zero)
    var onImageView = UIImageView(frame: CGRect.zero)
    var offImageView = UIImageView(frame: CGRect.zero)
    var onPoint = CGPoint.zero
    var offPoint = CGPoint.zero
    var isAnimating = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
}

// MARK: Private methods
extension SCCustomSwitch {
    fileprivate func setupUI() {
        // clear self before configuration
        clear()
        
        clipsToBounds = false
        
        // configure thumb view
        thumbView.backgroundColor = isOn ? thumbOnTintColor : thumbOffTintColor
        thumbView.isUserInteractionEnabled = false
        
        backgroundColor = isOn ? onTintColor : offTintColor
        //layer.borderWidth = borderWidth
        //layer.borderColor = borderColor.cgColor
        
        addSubview(thumbView)
        addSubview(onImageView)
        addSubview(offImageView)
        
        setupLabels()
    }
    
    
    private func clear() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        animate()
        return true
    }
    
    func setOn(on:Bool, animated:Bool) {
        
        switch animated {
        case true:
            animate(on: on)
        case false:
            isOn = on
            setupViewsOnAction()
            completeAction()
        }
    }
    
    fileprivate func animate(on:Bool? = nil) {
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
        setOnOffImageFrame()
    }

    private func completeAction() {
        isAnimating = false
        sendActions(for: UIControl.Event.valueChanged)
    }
    
}

// Mark: Public methods
extension SCCustomSwitch {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAnimating {
            layer.cornerRadius = bounds.size.height / 2
            backgroundColor = isOn ? onTintColor : offTintColor
            
            // thumb managment
            // get thumb size, if none set, use one from bounds
            let thumbSize = thumbSize != CGSize.zero ? thumbSize : CGSize(width: bounds.size.height, height: bounds.height)
            let yPostition = (bounds.size.height - thumbSize.height * 1.6) / 2
            
            onPoint = CGPoint(x: bounds.size.width - thumbSize.width * 1.6 + 2 + borderWidth, y: yPostition)
            offPoint = CGPoint(x: -borderWidth, y: yPostition)
            
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbView.frame.size.height *= 1.6
            thumbView.frame.size.width *= 1.6
            thumbView.layer.cornerRadius = thumbView.frame.height / 2  //* thumbCornerRadius
            //frame.size.height = thumbSize.height * 0.8
            
            
            //label frame
            if areLabelsShown {
                let labelWidth = bounds.width / 2 - padding * 2
                labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: frame.height)
                labelOff.frame = CGRect(x: frame.width - labelWidth, y: 0, width: labelWidth, height: frame.height)
            }
            
            // on/off images
            //set to preserve aspect ratio of image in thumbView
            
            guard onImage != nil && offImage != nil else { return }
            
            let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.7 : thumbSize.width * 0.7
            
            let onOffImageSize = CGSize(width: frameSize, height: frameSize)
            
            
            onImageView.frame.size = onOffImageSize
            offImageView.frame.size = onOffImageSize
            
            onImageView.center = CGPoint(x: onPoint.x + thumbView.frame.size.width / 2, y: thumbView.center.y)
            offImageView.center = CGPoint(x: offPoint.x + thumbView.frame.size.width / 2, y: thumbView.center.y)
            
            
            onImageView.alpha = isOn ? 1.0 : 0.0
            offImageView.alpha = isOn ? 0.0 : 1.0
            
        }
    }
}

//Mark: Labels frame
extension SCCustomSwitch {
    
    fileprivate func setupLabels() {
        guard areLabelsShown else {
            labelOff.alpha = 0
            labelOn.alpha = 0
            return
            
        }
        
        labelOff.alpha = 1
        labelOn.alpha = 1
        
        let labelWidth = bounds.width / 2 - padding * 2
        labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: frame.height)
        labelOff.frame = CGRect(x: frame.width - labelWidth, y: 0, width: labelWidth, height: frame.height)
        labelOn.font = UIFont.boldSystemFont(ofSize: 12)
        labelOff.font = UIFont.boldSystemFont(ofSize: 12)
        labelOn.textColor = UIColor.white
        labelOff.textColor = UIColor.white
        labelOff.sizeToFit()
        labelOff.text = "Off"
        labelOn.text = "On"
        labelOff.textAlignment = .center
        labelOn.textAlignment = .center
        
        insertSubview(labelOff, belowSubview: thumbView)
        insertSubview(labelOn, belowSubview: thumbView)
        
    }
    
}

extension SCCustomSwitch {
    
    private func setOnOffImageFrame() {
        guard onImage != nil && offImage != nil else { return }
        
        onImageView.center.x = isOn ? onPoint.x + thumbView.frame.size.width / 2 : frame.width
        offImageView.center.x = !isOn ? offPoint.x + thumbView.frame.size.width / 2 : 0
        onImageView.alpha = isOn ? 1.0 : 0.0
        offImageView.alpha = isOn ? 0.0 : 1.0
    }
}
