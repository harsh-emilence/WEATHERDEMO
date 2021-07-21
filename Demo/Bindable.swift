//
//  Bindable.swift
//  Demo
//
//  Created by Zimble on 21/07/21.
//

import Foundation
import UIKit

class Bindable<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T? {
        didSet {
            listener?(value!)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(listener: Listener?) {
        
        self.listener = listener
        listener?(value!)
    }
}
