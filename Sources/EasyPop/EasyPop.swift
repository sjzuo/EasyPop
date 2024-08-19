//
//  EasyPop.swift
//  Demo
//
//  Created by S JZ on 2024/7/30.
//

import UIKit

public class EasyPop {
    static public func toast(_ toastText: String, config: ToastConfig? = nil) {
        let toast = ToastPop()
        toast.toastText = toastText
        if let config { toast.toastConfig = config }
        toast.showPop()
    }
    
}





