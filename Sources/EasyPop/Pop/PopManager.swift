//
//  PopManager.swift
//  Demo
//
//  Created by S JZ on 2024/7/30.
//

import Foundation
import UIKit

class PopManager {
    
    var hiddenPop: (() -> ())?
    
    private lazy var superView: UIView? = keyWindow
    private lazy var containerView: UIView = UIView()
    
    private var hiddenFrame: CGRect = .zero
    private var showFrame: CGRect = .zero
    private var containerFrame: CGRect = .zero

    private lazy var maskView: UIView = {
        let maskView = UIView()
        maskView.alpha = 0.0
        maskView.frame = superView?.bounds ?? .zero
        return maskView
    }()
    
    func show(popView: PopType) {
        if let superView {
            self.containerView.isHidden = false
            if popView.config.isMask {
                maskView.backgroundColor = popView.config.maskColor
                
                if !superView.subviews.contains(maskView) {
                    superView.addSubview(maskView)
                }
                
                if popView.config.isTapMaskHidden {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(tapMaskView))
                    maskView.addGestureRecognizer(tap)
                }
            }else {
                if superView.subviews.contains(maskView) {
                    maskView.removeFromSuperview()
                }
            }
            
            handPop(popView: popView, superView: superView)
        }
    }
    
    @objc func tapMaskView() {
        hiddenPop?()
    }
    
    func handPop(popView: PopType, superView: UIView) {
        containerView.addSubview(popView)
        superView.addSubview(containerView)
        
        popView.layoutIfNeeded()
        containerView.layoutIfNeeded()
        
        hiddenFrame = popView.frame
        showFrame = popView.frame
        containerFrame = popView.frame
        
        if popView.config.direction == .center {
            hiddenFrame.origin.x = 0
            showFrame.origin.x = 0
            
            hiddenFrame.origin.y = 0
            showFrame.origin.y = 0
            
            containerFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
            containerFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
        }else if popView.config.direction == .top {
            hiddenFrame.origin.y = -popView.frame.origin.y
            hiddenFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
            
            showFrame.origin.y = 0
            showFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
            
            if popView.config.isShowFromEdge {
                containerFrame.origin.y = 0
                containerFrame.size.height += popView.config.showPosition
            }else {
                containerFrame.origin.y = 0 + popView.config.showPosition
            }
           
            containerFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
        }else if popView.config.direction == .bottom {
            hiddenFrame.origin.y = hiddenFrame.height
            hiddenFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
            
            showFrame.origin.y = 0
            showFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
            
            if popView.config.isShowFromEdge {
                containerFrame.size.height += popView.config.showPosition
            }
            containerFrame.origin.y = scrreen_height - showFrame.size.height - popView.config.showPosition
            containerFrame.origin.x = (scrreen_width - popView.frame.size.width) / 2
        }else if popView.config.direction == .left {
            hiddenFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
            hiddenFrame.origin.x = -popView.frame.origin.x
            
            showFrame.origin.x = 0
            showFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
            
            showFrame.origin.x = 0
            showFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
        }else if popView.config.direction == .right {
            hiddenFrame.origin.x =  hiddenFrame.width
            hiddenFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
            
            showFrame.origin.x = 0
            showFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
            
            containerFrame.origin.x = scrreen_width - showFrame.size.width
            containerFrame.origin.y = (scrreen_height - popView.frame.size.height) / 2
        }
        
        popView.frame = hiddenFrame
        
        containerView.frame = containerFrame
        containerView.backgroundColor = .clear
        containerView.clipsToBounds = true
        
        if popView.config.isMask {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.maskView.alpha = 1.0
            }
        }
        
        UIView.animate(withDuration: popView.config.animationTime) { [weak self] in
            guard let self = self else { return }
            
            popView.frame = self.showFrame
        }
    }
    
    func hidden(popView: PopType, complate: @escaping () -> ()) {
        UIView.animate(withDuration: popView.config.animationTime) { [weak self] in
            guard let self = self else { return }
            popView.frame = self.hiddenFrame
        } completion: { [weak self] completion in
            guard let self = self else { return }
            
            popView.isHidden = true
            popView.removeFromSuperview()
            
            complate()
            
            if let pop = PopQueue.shared.getNextPop() {
                self.show(popView: pop)
            }else {
                self.containerView.isHidden = true
                self.containerView.removeFromSuperview()
                
                if popView.config.isMask {
                    UIView.animate(withDuration: 0.2) { [weak self] in
                        guard let self = self else { return }
                        self.maskView.alpha = 0.0
                    } completion: { [weak self] completion in
                        guard let self = self else { return }
                        self.maskView.removeFromSuperview()
                    }
                }
            }
        }
    }
}

