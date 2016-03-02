//
//  Quiz.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/20.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import Foundation

/** クイズ　データクラス */
class Quiz {
    
    /** 問題文 */
    var question: [String]
    
    /** 選択肢 */
    var selection: [String]
    
    /** 正解 */
    var answer: Int
    
    init(question: [String], selection: [String], answer: Int) {
        self.question = question
        self.selection = selection
        self.answer = answer
    }
    
    init() {
        self.question = []
        self.selection = []
        self.answer = -1
    }
}