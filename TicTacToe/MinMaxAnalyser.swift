//
//  MinMaxNode.swift
//  Sudoko2
//
//  Created by Vermeer on 13/11/2020.
//

import Foundation


class MinMaxSolver {
        
    
    let possibleMoves = [0,1,2,3,4,5,6,7,8]
    var playerStarted = true
    
    func analyse(moveList:[Int] , playerStart: Bool) -> (node:Int, score:Int) {
        
        self.playerStarted = playerStart
        var moves:[Int] = Array(Set(possibleMoves).subtracting(Set(moveList)))
        moves.sort()
        let movestogo = moves.count
        
        if moveList.count == 8{
            let node = moves[0]
            var evalMoveList = moveList
            evalMoveList.append(node)
            let winner = evalWinner(moves: evalMoveList)
            if (playerStarted && winner){
                return (node:node, score:2)
            }
            if (!playerStarted && winner){
                return (node:node, score:1)
            }
            return (node:node, score:0)
        }
        
        
        // Max calculation
        
        var foundWinner: Bool = false
        var score = 0
        var bestMove=0
        
        
        if (playerStarted && moveList.count%2==1 || !playerStarted && moveList.count%2==0){
            score = 0
            bestMove = moves[0]
            for move in moves {
              //  print("Maxevaluation", move)
                var evalMoves = moveList
                evalMoves.append(move)
                // Check winning move
                if checkWin(evalMoves: evalMoves){
                    if !foundWinner{
                        score = movestogo * 10
                    }
                    foundWinner = true
                    bestMove = move
                    score = score + 1
                } else {
                    
                    let result = analyse(moveList: evalMoves, playerStart: playerStarted)
                    
                    if  result.score > score {
                        score = result.score
                        bestMove = result.node
                    }
                    
                }
            }
            return (node:bestMove, score:score)
        }
        
        // Mincalculation
        //print("min calcutation")
        score = 0
        var foundLoser = false
        bestMove = moves[0]
        for move in moves {
            var evalMoves = moveList
            evalMoves.append(move)
            if checkWin(evalMoves: evalMoves){
                if !foundLoser {
                    score = (movestogo*10)
                }
                foundLoser = true
                score = score + 1
                bestMove = move
            } else {
                
                let result = analyse(moveList: evalMoves, playerStart: playerStarted)
                if  result.score > score {
                    score = result.score
                    bestMove = result.node
                }
            }
            
        }
        return (node:bestMove, score:score)
    }
    
    
    func checkWin(evalMoves:[Int])->Bool{
        
        var analyseMoves:[Int] = []
        var numMoves = evalMoves.count/2
        var offset = 0
        
        if evalMoves.count%2 == 0 {
            offset = 1
            numMoves = numMoves-1
        }
            
        for t in 0...numMoves{
            analyseMoves.append(evalMoves[t*2 + offset])
        }
        
        return evalWinner(moves: analyseMoves)
    }
    
    func evalWinner(moves:[Int])-> Bool{
        
        for x in 0...2 {  // Horizontal win
            if  moves.contains(x*3) &&
                moves.contains(x*3+1) &&
                moves.contains(x*3+2)
            {
              //  print ("horizonatl win")
                return true
            }
            
            if  moves.contains(x) && // Vertical win
                moves.contains(x+3) &&
                moves.contains(x+6)
            {
                return true
            }
        }
        
        if moves.contains(0) &&
            moves.contains(4) &&
            moves.contains(8) {
            
            return true
        }
        
        if moves.contains(2) &&
            moves.contains(4) &&
            moves.contains(6) {
            return true
        }
        return false
    }
    
    
    
}

