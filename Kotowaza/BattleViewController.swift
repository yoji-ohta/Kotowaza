//
//  NextViewController.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/20.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, QuizMasterDelegate {
    
    @IBOutlet weak var battleView: SKView!
    
    @IBOutlet weak var novelView: GameTextsView!
    
    @IBOutlet weak var pauseBtn: UIButton!
    
    private var answerPad: AnswerPad?
    
    private var gameOverFlg: Bool = false
    
    private var quizMaster: QuizMaster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        novelView.startDisplayingText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapView:"))
        self.novelView.setDisplayText("こんにちは")
        self.quizMaster = QuizMaster(quizId: 1)
        self.quizMaster.delegate = self
        
        // init BattleView
        self.battleView.showsFPS = true
        self.battleView.showsNodeCount = true
        self.battleView.ignoresSiblingOrder = true
        
        let battleScene = BattleScene()
        battleScene.size = battleView.frame.size
        battleScene.scaleMode = SKSceneScaleMode.AspectFill
        
        battleView.presentScene(battleScene)
    }
    
    func tapView(gesture: UITapGestureRecognizer) {
        if novelView.isTextDisplayingCompleted {
            if !quizMaster.getQuiz().question.isEmpty {
                novelView.cleanup()
                novelView.setDisplayText(quizMaster.getQuiz().question.removeAtIndex(0))
                novelView.startDisplayingText()
            } else {
                novelView.cleanup()
                self.answerPad = AnswerPad(frame: novelView.frame)
                answerPad!.frame.origin = CGPoint(x: 0, y: 0)
                
                novelView.addSubview(answerPad!)
                answerPad!.setSelectionString(quizMaster.getQuiz().selection)

            }
        } else {
            novelView.displayAllText()
        }
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
    
    
    func answer(button: UIButton) {
        print("helo")
        quizMaster.isTelledAnswer(button.tag)
    }
    
    func masterTellsResult(result: QuizResult) {
        switch result.result {
        case .Correct:
            break
        case .InCorrect:
            self.gameOverFlg = true
            (self.battleView.scene as! BattleScene).runFailureAnimation()
        }
        print(result.result)
        self.answerPad?.removeFromSuperview()
        
        self.novelView.setDisplayText(result.serihu)
        self.novelView.startDisplayingText()
    }
    
    // MARK: - PauseViewDelegate
    
    func didTapGoTitleBtn() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTapBackGameBtn() {
        
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
