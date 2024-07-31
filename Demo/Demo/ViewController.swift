//
//  ViewController.swift
//  Demo
//
//  Created by S JZ on 2024/7/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let toast = ToastPop()
//        toast.center = view.center
//        view.addSubview(toast)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let demo = EasyDemo(frame: CGRect(x: 0, y: 0, width: scrreen_width, height: 200))
//        demo.backgroundColor = .white
//        PopQueue.shared.insertPop(demo)
//        
//        let demo1 = EasyDemo(frame: CGRect(x: 0, y: 0, width: scrreen_width, height: 200))
//        demo1.backgroundColor = .red
//        PopQueue.shared.insertPop(demo1)
//        
//        let demo3 = EasyDemo(frame: CGRect(x: 0, y: 0, width: scrreen_width, height: 200))
//        demo3.backgroundColor = .yellow
//        demo3.config.priority = .unique
//        PopQueue.shared.insertPop(demo3)
        
        let toast = ToastPop()
        PopQueue.shared.insertPop(toast)
        
    }

}

