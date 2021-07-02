//
//  ViewController.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 05/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var bottomView: BaseView = {
        let view = BaseView(frame: CGRect(x: 100, y: 100, width: 84, height: 36))
        view.borderWidth = 3
        return view
    }()
    
    private lazy var customSwitch: SCCustomSwitch = {
        let customSwitch = SCCustomSwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = UIColor.yellow
        customSwitch.offTintColor = UIColor.white
        customSwitch.cornerRadius = customSwitch.bounds.height / 2
        customSwitch.thumbCornerRadius = customSwitch.thumbView.bounds.height / 2
        customSwitch.thumbOffTintColor = .black
        customSwitch.thumbOnTintColor = .yellow
        customSwitch.thumbBorderWidth = 2
        customSwitch.thumbBorderColor = .black
        customSwitch.borderWidth = 2
        customSwitch.borderColor = .black
        customSwitch.animationDuration = 0.25
        return customSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(bottomView)
        //bottomView.addSubview(customSwitch)
        setupConstraints()
    }
    
    private func setupConstraints(){
            NSLayoutConstraint.activate([
                                            bottomView.topAnchor.constraint(equalTo: view.centerYAnchor),
                                            bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                            bottomView.widthAnchor.constraint(equalToConstant: 84),
                                            bottomView.heightAnchor.constraint(equalToConstant: 36)])//,
                //customSwitch.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor),
                //customSwitch.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor),
                //customSwitch.widthAnchor.constraint(equalToConstant: 80),
                //customSwitch.heightAnchor.constraint(equalToConstant: 32)])
        }
    
   
}
