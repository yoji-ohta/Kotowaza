//
//  PauseView.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/23.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import UIKit

class PauseView: UIView {
    
    var didTapGoTitle: (() -> Void)?
    var didTapBackGame: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comminInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comminInit()
    }
    
    private func comminInit() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PauseView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        addSubview(view)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapView:"))
        // カスタムViewのサイズを自分自身と同じサイズにする
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        
    }

    @IBAction func tapGoTitleBtn(sender: UIButton) {
        didTapGoTitle?()
    }
    
    @IBAction func tapBackGameBtn(sender: UIButton) {
        didTapBackGame?()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
