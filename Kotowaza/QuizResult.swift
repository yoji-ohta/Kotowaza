//
//  QuizResult.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/20.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import Foundation

enum Result {
    case Correct, InCorrect
}

class QuizResult {
    
    var result: Result
    var serihu: String
    
    init(result: Result, serihu: String) {
        self.result = result
        self.serihu = serihu
    }
}