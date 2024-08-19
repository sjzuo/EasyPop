//
//  PopQueue.swift
//  Demo
//
//  Created by S JZ on 2024/7/30.
//

import Foundation
import UIKit

public class PopQueue {
    static public let shared: PopQueue = PopQueue()
    
    private var highList: [PopType] = []
    private var normalList: [PopType] = []
    private var lowList: [PopType] = []
    
    private lazy var manager: PopManager = {
        let manager = PopManager()
        manager.hiddenPop = { [weak self] in
            guard let self = self else { return }
            self.removePop()
        }
        return manager
    }()
    
    public func insertPop(_ type: PopType) {
        if type.config.priority == .high {
            highList.append(type)
        }else if type.config.priority == .normal {
            normalList.append(type)
        }else if type.config.priority == .low {
            lowList.append(type)
        }else if type.config.priority == .interFirst {
            if(highList.isEmpty) {
                highList.append(type)
            }else {
                highList.insert(type, at: 0)
            }
        }else if type.config.priority == .unique {
            if let pop = getNextPop() {
                pop.isHidden = true
                pop.removeFromSuperview()
            }
            clearPop()
            highList.append(type)
        }
        
        if getPopCount() == 1 {
            showPop()
        }
    }
    
    public func showPop() {
        if let pop = getNextPop() { manager.show(popView: pop) }
    }
    
    public func removePop(_ type: PopType? = nil) {
        if let type {
            manager.hidden(popView: type) { [weak self] in
                guard let self = self else { return }
                if type.config.priority == .high || type.config.priority == .interFirst || type.config.priority == .unique {
                    self.highList = self.highList.filter({ $0.config.identifier != type.config.identifier })
                }else if type.config.priority == .normal {
                    self.normalList = self.normalList.filter({ $0.config.identifier != type.config.identifier })
                }else if type.config.priority == .low {
                    self.lowList = self.lowList.filter({ $0.config.identifier != type.config.identifier })
                }
            }
        }else {
            if let pop = getNextPop() { removePop(pop) }
        }
    }
    
    public func clearPop() {
        highList = []
        normalList = []
        lowList = []
    }
    
    public func getNextPop() -> PopType? {
        if !highList.isEmpty { return highList[0] }
        if !normalList.isEmpty { return normalList[0] }
        if(!lowList.isEmpty) { return lowList[0] }
        
        return nil
    }
    
    public func getPopCount() -> Int {
        return highList.count + normalList.count + lowList.count
    }
}

