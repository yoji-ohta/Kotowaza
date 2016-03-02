//
//  DramaViewController.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/27.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import UIKit

class DramaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tapBackBtn(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapPauseBtn(sender: UIButton) {
        let pauseView = PauseView(frame: self.view.frame)
        pauseView.didTapBackGame = {
            UIView.animateWithDuration(0.5,
                animations: {
                    pauseView.layer.opacity = 0
                },
                completion: {(completion) in
                    pauseView.removeFromSuperview()
            })
        }
        
        pauseView.didTapGoTitle = {
            UIView.animateWithDuration(0.5,
                animations: {
                    pauseView.layer.opacity = 0
                },
                completion: {(completion) in
                    pauseView.removeFromSuperview()
                    self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        
        self.view.addSubview(pauseView)
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
