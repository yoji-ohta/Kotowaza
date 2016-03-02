//
//  AnswerPad.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/15.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import UIKit

class AnswerPad: UIView {
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commintInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commintInit()
    }
    
    func commintInit() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "AnswerPad", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        addSubview(view)
        
        self.backgroundColor = UIColor.whiteColor()
        
        aButton.addTarget(nil, action: "answer:", forControlEvents: .TouchUpInside)
        bButton.addTarget(nil, action: "answer:", forControlEvents: .TouchUpInside)
        cButton.addTarget(nil, action: "answer:", forControlEvents: .TouchUpInside)
        dButton.addTarget(nil, action: "answer:", forControlEvents: .TouchUpInside)
        
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
    
    func setSelectionString(selection: [String]) {
        for (num, str) in selection.enumerate() {
            switch num {
            case 0: aButton.setTitle(str, forState: .Normal)
            case 1: bButton.setTitle(str, forState: .Normal)
            case 2: cButton.setTitle(str, forState: .Normal)
            case 3: dButton.setTitle(str, forState: .Normal)
            default:
                fatalError("dame")
            }
        }
    }
    
//    func answer(btn: UIButton) {
//        print("answer")
//    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
