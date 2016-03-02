//
//  GameTextsView.swift
//  SRGNovelGameTexts
//
//  Created by 太田洋司 on 2016/01/05.
//  Copyright © 2016年 Soragoto. All rights reserved.
//

import UIKit

class GameTextsView: UIView {
    var textColor: UIColor = UIColor.blackColor()
    var font: UIFont = UIFont.systemFontOfSize(18)
    var letterSpacing: CGFloat = 1.0
    var lineSpacing: CGFloat = 8.0
    var stringDisplaySpeed: Double = 0.1
    var stringFadeInSpeed: Double = 0.1
    
    var isTextDisplayingCompleted: Bool = false
    
    var onAllTextDisplayed: (() -> Void)?
    
    private var displayText: String = ""
    private var displayTextScheduler: NSTimer?
    
    private var textCountInCurrentLine: Int = 0
    private var lineCount: Int = 0
//    private var lineBreakPoint: Array<Index> = []
    
    private var stringLabels: Array<UILabel> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public methods
    
    func setDisplayText(text: String) {
        self.isTextDisplayingCompleted = false
        
//        self.lineBreakPoint = []
        self.displayText = self.parseLineBreakMark(text)
        
        self.createStringLabels()
    }
    
    func startDisplayingText() {
        displayTextScheduler = NSTimer.scheduledTimerWithTimeInterval(stringDisplaySpeed,
            target: self,
            selector: "displayStringNextOne",
            userInfo: nil,
            repeats: true)
    }
    
    func displayAllText() {
        for label in stringLabels {
            label.hidden = false
        }
        self.onAllStringDisplayed()
    }
    
    func cleanup() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        if let scheduler = displayTextScheduler {
            scheduler.invalidate()
        }
        displayTextScheduler = nil
        displayText = ""
        stringLabels = []
        lineCount = 0
        textCountInCurrentLine = 0
    }
    
    //MARK: - Create Label Parts
    
    private func createStringLabels() {
        while !isStringLabelCreatingCompleted() {
            self.createNextStringLabel()
        }
        self.adjustViewFrame()
    }
    
    private func createNextStringLabel() {
        if let nextString = self.nextString() {
            let str = labelWithString(nextString)
            str.hidden = true
            str.sizeToFit()
            self.setPositionWithLabel(str)
            
            self.addSubview(str)
            stringLabels.append(str)
            textCountInCurrentLine++
        }
    }
    
    private func labelWithString(str: String) -> UILabel {
        let label = UILabel()
        label.text = str
        label.textColor = self.textColor
        label.backgroundColor = UIColor.clearColor()
        label.font = self.font
        return label
    }
    
    private func isStringLabelCreatingCompleted() -> Bool {
        // TODO: - iOS8でcharacters.countは使えるか
        return stringLabels.count == displayText.characters.count
    }
    
    //MARK: - Adjust label position
    
    private func setPositionWithLabel(label: UILabel) {
        let _preAdded = stringLabels.last
        
        guard let preAdded = _preAdded else {
            self.setXPosWithUIView(label, x: 0)
            self.setYPosWithUIView(label, y: 0)
            lineCount = 1
            return
        }
        
        let nextStringXpos = preAdded.frame.origin.x + preAdded.frame.size.width + letterSpacing
        let isNeedLineBreak = nextStringXpos > self.frame.size.width
        
        if isNeedLineBreak {
            self.setYPosWithUIView(label,
                y: (label.frame.size.height + lineSpacing) * CGFloat(lineCount))
            self.setXPosWithUIView(label, x: 0)
            lineCount++
            textCountInCurrentLine = 0
            return
        }
        
        self.setXPosWithUIView(label,
            x: preAdded.frame.origin.x + preAdded.frame.size.width + letterSpacing)
        self.setYPosWithUIView(label, y: preAdded.frame.origin.y)
    }
    
    private func adjustViewFrame() {
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
        
        for label in stringLabels {
            let frameOrigin: CGPoint = label.frame.origin
            let frameSize: CGSize = label.frame.size
            let labelsMaxX = frameOrigin.x + frameSize.width
            let labelsMaxY = frameOrigin.y + frameSize.height
            if labelsMaxX > maxX {
                maxX = labelsMaxX
            }
            if labelsMaxY > maxY {
                maxY = labelsMaxY
            }
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, maxX, maxY)
    }
    
    //MARK: - Display label parts
    
    func displayStringNextOne() {
        for label in stringLabels {
            if label.hidden {
                label.alpha = 0
                label.hidden = false
                UIView.animateWithDuration(stringFadeInSpeed,
                    animations: { label.alpha = 1 })
                return
            }
        }
        if let scheduler = displayTextScheduler {
            scheduler.invalidate()
        }
        self.onAllStringDisplayed()
    }
    
    private func nextString() -> String? {
        if isStringLabelCreatingCompleted() {
            return nil
        }
        let index = displayText.startIndex.advancedBy(stringLabels.count)
        return displayText.substringWithRange(index..<index.successor())
    }
    
    private func onAllStringDisplayed() {
        isTextDisplayingCompleted = true
        
        onAllTextDisplayed?()
    }
    
    //MARK: - misc
    
    private func parseLineBreakMark(var text: String) -> String {
        let range = text.rangeOfString("\n")
        if let range = range {
//            lineBreakPoint.append(range.first!)
            text.removeRange(range)
        }
        return text
    }
    
    private func setXPosWithUIView(view: UIView, x: CGFloat) {
        view.frame.origin.x = x
    }
    
    private func setYPosWithUIView(view: UIView, y: CGFloat) {
        view.frame.origin.y = y
    }
}










