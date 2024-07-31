//
//  EasyDemo.swift
//  Demo
//
//  Created by S JZ on 2024/7/30.
//

import UIKit

class EasyDemo: UIView, PopType {
    var identifier: UUID = UUID()
    var config: PopConfig = PopConfig()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config.direction = .bottom
        config.isTapMaskHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
