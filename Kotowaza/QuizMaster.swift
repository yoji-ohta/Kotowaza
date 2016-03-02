//
//  QuizMaster.swift
//  Kotowaza
//
//  Created by 太田洋司 on 2016/02/20.
//  Copyright © 2016年 yjsan. All rights reserved.
//

import Foundation

protocol QuizMasterDelegate {
    func masterTellsResult(result: QuizResult)
}

class QuizMaster {
    
    var delegate: QuizMasterDelegate?
    
    private var quiz: Quiz
    
    init(quizId: Int) {
        let path = NSBundle.mainBundle().pathForResource("Quiz", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)!
        if let aDict = dict.objectForKey(quizId.description) {
            let question = aDict.objectForKey("question") as! Array<String>
            let selection = aDict.objectForKey("selection") as! Array<String>
            let answer = aDict.objectForKey("answer") as! Int
            
            self.quiz = Quiz(question: question, selection: selection, answer: answer)
        } else {
            log.debug("there's any quiz, sorry. id: \(quizId)")
            self.quiz = Quiz()
        }
    }
    
    /** idによりQuizを取得 */
//    func getQuiz(id: Int) -> Quiz? {
//        
//        let path = NSBundle.mainBundle().pathForResource("Quiz", ofType: "plist")
//        let dict = NSDictionary(contentsOfFile: path!)!
//        if let aDict = dict.objectForKey(id.description) {
//            let question = aDict.objectForKey("question") as! Array<String>
//            let selection = aDict.objectForKey("selection") as! Array<String>
//            let answer = aDict.objectForKey("answer") as! Int
//            
//            return Quiz(question: question, selection: selection, answer: answer)
//        } else {
//            print("there's any quiz, sorry. id: \(id)")
//            return nil
//        }
//    }
    
    func getQuiz() -> Quiz {
        return self.quiz
    }
    
    func isTelledAnswer(answer: Int) {
        let result: QuizResult
        if answer == self.quiz.answer {
            result = QuizResult(result: .Correct, serihu: "なん…だとっ……！！！！")
        } else {
            result = QuizResult(result: .InCorrect, serihu: "え？")
        }
        print(result)
        
        delegate?.masterTellsResult(result)
    }
    
}