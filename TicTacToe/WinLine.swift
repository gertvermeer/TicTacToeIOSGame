//
//  WinLines.swift
//  Sudoko2
//
//  Created by Vermeer on 17/11/2020.
//

import UIKit

class WinLine: UIView {
    
    
    
    var line = UIBezierPath()
    var choice = 8 //  geen lijn
    
    func drawLine(stroke:Int)
    {
        var start = CGPoint()
        var end = CGPoint()
        let indent :CGFloat =  15
        switch stroke {
        case 0:
            start.x = indent
            start.y = bounds.height/6
            end.x = bounds.width - indent
            end.y = bounds.height/6
        case 1:
            start.x = indent
            start.y = bounds.height/2
            end.x = bounds.width - indent
            end.y = bounds.height/2
        case 2:
            start.x = indent
            start.y = bounds.height*5/6
            end.x = bounds.width - indent
            end.y = bounds.height*5/6
        case 3:
            start.x = bounds.width/6
            start.y = indent
            end.x = bounds.width/6
            end.y = bounds.height - indent
        case 4:
            start.x = bounds.width/2
            start.y =  indent
            end.x = bounds.width/2
            end.y = bounds.height - indent
        case 5:
            start.x = bounds.width*5/6
            start.y = indent
            end.x = bounds.width*5/6
            end.y = bounds.height - indent
        case 6:
            start.x = indent
            start.y = indent
            end.x = bounds.width - indent
            end.y = bounds.height - indent
        case 7:
            start.x = indent
            start.y = bounds.height - indent
            end.x = bounds.width - indent
            end.y = indent
        case 8:
            start.x = indent
            start.y = indent
            end.x = indent
            end.y = indent
        default:
            start.x = indent
            start.y = indent
            end.x = indent
            end.y = indent
            
        }
        
        
        
        line.removeAllPoints()
        
        line.move(to: start)
        line.addLine(to: end)
        UIColor.orange.setStroke()
        line.lineWidth=6
        line.stroke()
        
        
        
    }
        
    func printWinLine (winner:Int){
        print("Winline" , winner)
        self.choice = winner
        if  choice < 8 {
            self.alpha = 1
        } else {
            self.alpha = 0
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
            //self.backgroundColor = .red
            drawLine(stroke:choice)
    }
 
}
