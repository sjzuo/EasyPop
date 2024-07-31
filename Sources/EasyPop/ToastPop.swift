//
//  ToastPop.swift
//  Demo
//
//  Created by S JZ on 2024/7/31.
//

import UIKit

public class ToastConfig {
    var titleColor: UIColor = .white
    var titleFont: UIFont = .systemFont(ofSize: 17)
    var titleInsert: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    
    var toastMaskColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    var toastMaskCornerRadius: CGFloat = 5.0
    var toastDuration: CGFloat = 3.0
    var toastMaxWidth: CGFloat = 300.0
}

public class ToastPop: UIView, PopType {
    public var toastConfig: ToastConfig = ToastConfig() {
        didSet {
            titleLabel.textColor = toastConfig.titleColor
            titleLabel.font = toastConfig.titleFont
            
            toastMaskView.backgroundColor = toastConfig.toastMaskColor
            if toastConfig.toastMaskCornerRadius > 0 {
                toastMaskView.layer.cornerRadius = toastConfig.toastMaskCornerRadius
                toastMaskView.layer.masksToBounds = true
            }
        }
    }
    
    public var config: PopConfig = PopConfig()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "我知道了，请见谅"
        titleLabel.textColor = toastConfig.titleColor
        titleLabel.font = toastConfig.titleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var toastMaskView: UIView = {
        let toastMaskView = UIView()
        toastMaskView.backgroundColor = toastConfig.toastMaskColor
        if toastConfig.toastMaskCornerRadius > 0 {
            toastMaskView.layer.cornerRadius = toastConfig.toastMaskCornerRadius
            toastMaskView.layer.masksToBounds = true
        }
        return toastMaskView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.config.isMask = false
        self.config.direction = .center
        self.config.animationTime = 0.2
        self.config.priority = .high
        
        addSubview(toastMaskView)
        toastMaskView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        toastMaskView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        toastMaskView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        toastMaskView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        toastMaskView.widthAnchor.constraint(lessThanOrEqualToConstant: toastConfig.toastMaxWidth).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: toastMaskView.leftAnchor, constant: toastConfig.titleInsert.left).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: toastMaskView.rightAnchor, constant: -toastConfig.titleInsert.right).isActive = true
        titleLabel.topAnchor.constraint(equalTo: toastMaskView.topAnchor, constant: toastConfig.titleInsert.top).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: toastMaskView.bottomAnchor, constant: -toastConfig.titleInsert.bottom).isActive = true
        
        self.leftAnchor.constraint(equalTo: toastMaskView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: toastMaskView.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: toastMaskView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: toastMaskView.bottomAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + toastConfig.toastDuration) { [weak self] in
            guard let self = self else { return }
            self.dismisPop()
        }
    }
}
