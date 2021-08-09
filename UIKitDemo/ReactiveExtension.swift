//
//  ReactiveExtension.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 09/08/2021.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: CustomSwitch {
    var isOnValue: ControlProperty<Bool> {
        return controlProperty(editingEvents: .valueChanged,
                               getter: { $0.isOn },
                               setter: { $0.isOn = $1 })
    }
}
