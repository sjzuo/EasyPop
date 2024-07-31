//
//  PopType.swift
//  Demo
//
//  Created by S JZ on 2024/7/30.
//

import Foundation
import UIKit

// MARK: 获取KeyWindow
public var keyWindow: UIWindow? {
    // iOS13.0 之前获取方式
    // UIApplication.shared.keyWindow
    let windowScreen = UIApplication.shared.connectedScenes.first as? UIWindowScene
    return windowScreen?.windows.first { key in
        key.isKeyWindow
    }
}
public var scrreen_width: CGFloat { return keyWindow?.frame.size.width ?? 0.0 }
public var scrreen_height: CGFloat { return keyWindow?.frame.size.height ?? 0.0 }


public enum PopPriority {
    // 弹窗优先级默认
    case normal
    // 弹窗优先级高
    case high
    // 弹窗优先级低
    case low
    // 优先展示弹窗，排到接下来的第一个
    case interFirst
    // 唯一
    case unique
}

public enum PopDirection: Int {
    case center = 0
    case top
    case bottom
    case left
    case right
}

public class PopConfig {
    public private(set) var identifier: UUID = UUID()
    // 弹窗的方向
    public var direction: PopDirection = .center
    // 弹窗的优先级
    public var priority: PopPriority = .normal
    // 动画的时间
    public var animationTime: CGFloat = 0.5
    
    // 是否从屏幕边缘，动画到相应位置
    public var isShowFromEdge: Bool = true
    // 距离屏幕边缘的位置，只对top 和 bottom起作用
    public var showPosition: CGFloat = 0.0
    
    // 遮罩相关
    public var isMask: Bool = true
    public var isTapMaskHidden: Bool = false
    public var maskColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
}

public protocol PopType where Self: UIView {
    var config: PopConfig { get }
    func showPop()
    func dismisPop()
}

public extension PopType {
    func showPop() {
        PopQueue.shared.insertPop(self)
    }
    
    func dismisPop() {
        PopQueue.shared.removePop(self)
    }
}

