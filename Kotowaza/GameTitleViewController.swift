//
//  GameTitleViewController.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/04.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import UIKit

class GameTitleViewController: UIViewController {

    @IBOutlet private weak var newGameBtn: UIButton!
    
    @IBOutlet private weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initView() {
        for btn in [newGameBtn, continueBtn] {
            self.decorateBtns(btn)
        }
    }
    
    private func decorateBtns(btn: UIButton) {
        btn.backgroundColor = UIColor.lightGrayColor()
        btn.layer.cornerRadius = 7
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
