//
//  ScoreController.swift
//  Sudoko2
//
//  Created by Vermeer on 11/11/2020.
//

import Foundation
import UIKit


class ScoreController : UIViewController {

    var boardScore :[[Character]] = [["-","-","-"],["-","-","-"],["-","-","-"]]
    var winner = false
    
    var collectionViewList: [blockCollectionView] = []
    
    var message: UILabel = UILabel()
    
    var minMaxNode : MinMaxSolver = MinMaxSolver()
    var moveList:[Int] = []
    
    var playerStart = true
    var winLine = WinLine()
    
    func setup(label: UILabel, playStart:Bool, winLine:WinLine){
        self.message = label
        self.playerStart = playStart
        self.winLine = winLine
    }
    
    func setPlayerStart(setting: Bool){
        self.playerStart = setting
        newGame()
    }
    
    
    func addCollectionView(collectionView:blockCollectionView){
        collectionViewList.append(collectionView)
    }
    
    
    func registerMove(move:Int) -> Bool {
        
        if winner {
            return false
        }
        let x:Int = move/3
        let y:Int = move%3
        if boardScore[x][y] != "-" {
            showMessage(mes: "Ongeldige zet", sleepTime: 1)
            return false
        }
        moveList.append(move)
        boardScore[move/3][move%3] = "X"
        checkWinner()
        
        if winner {
            return true
        }
        
        print(moveList.count, moveList)
        if moveList.count == 9  {
            showMessage(mes: "Gelijk spel", sleepTime: 0)
            return true
        }
        
        let move = minMaxNode.analyse(moveList: moveList, playerStart: playerStart)
        boardScore[move.node/3][move.node%3] = "O"
        collectionViewList[move.node].autoPressCell(char:"O")
        moveList.append(move.node)
        
        checkWinner()
    
        return true
    }

    func showMessage(mes: String, sleepTime:Int){
        message.text = mes
        if sleepTime > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.message.text = ""
            }
        }
        
    }
    
    func nextMove()-> (x:Int, y:Int){
        for x in 0...2 {
            for y in 0...2 {
                if boardScore[x][y] == "-" {
                    return (x,y)
                }
            }
        }
        return (0,0)
    }
    
    func checkWinner(){
       
      
        
      var result : Character = "-"
       
        
        print (boardScore)
        for x in 0...2 {
            if boardScore[x][0] == boardScore[x][1]
                && boardScore[x][1] == boardScore[x][2]
                && boardScore[x][0] != "-" {
                result = boardScore[x][0]
                winLine.printWinLine(winner:x)
            }
            if boardScore[0][x] == boardScore[1][x]
                && boardScore[1][x] == boardScore[2][x]
                && boardScore[0][x] != "-" {
                result = boardScore[0][x]
                winLine.printWinLine(winner:x+3)
            }
        }
        
        if boardScore[0][0] == boardScore[1][1]
            && boardScore[1][1] == boardScore[2][2]
            && boardScore[0][0] != "-" {
            print("WINNER")
            result = boardScore[0][0]
            winLine.printWinLine(winner:6)
        }
        
        if boardScore[0][2] == boardScore[1][1]
            && boardScore[1][1] == boardScore[2][0]
            && boardScore[1][1] != "-" {
            result = boardScore[0][2]
            winLine.printWinLine(winner:7)
        }
        
        print ("Result ", result)
        if result != "-" {
            showMessage(mes: String(result) + " heeft gewonnen", sleepTime: 0)
            winner = true
        }

    }
    
    func newGame(){
       
        winLine.printWinLine(winner: 8)
        
        boardScore = [["-","-","-"],["-","-","-"],["-","-","-"]]
        for t in 0...8 {
            collectionViewList[t].autoPressCell(char:" ")
            collectionViewList[t].backgroundColor = .purple
        }
        winner = false
        if playerStart{
            moveList = []
        } else {
            moveList=[0]
            boardScore[0][0] = "O"
            collectionViewList[0].autoPressCell(char:"O")
        }
        
        
    }
    
}
