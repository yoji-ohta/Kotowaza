//
//  BattleScene.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/15.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import UIKit

class BattleScene: SKScene {
    
    var mEnemyNode: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {

        initEnemyNode()
    }
    
    private func initEnemyNode() {
        let texture = SKTexture(imageNamed: "turutontan")
        mEnemyNode = SKSpriteNode(texture: texture)
        mEnemyNode.position = self.view!.center
        self.addChild(mEnemyNode)
    }
    
    func runCorrectAnimation() {

        
    }
    
    func runFailureAnimation() {
        let animation1 = SKAction.moveByX(50, y: 0, duration: 0.5)
        let animation2 = SKAction.moveByX(-100, y: 0, duration: 0.5)
        let animation3 = SKAction.moveByX(50, y: 0, duration: 0.5)
        let scerialAnimation = SKAction.sequence([animation1, animation2, animation3])
        self.mEnemyNode.runAction(scerialAnimation)
    }
}







