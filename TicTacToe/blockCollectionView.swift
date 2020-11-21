//
//  blockCollectionView.swift
//  Sudoko2
//
//  Created by Vermeer on 10/11/2020.
//

import UIKit

class blockCollectionView: UICollectionViewCell {
    
    
    var scoreController: ScoreController?
    var cellNumber:Int?
    

  //  @IBOutlet weak var label: UILabel!
    

    @IBOutlet weak var buttonText: UIButton!
    @IBAction func pressCell(_ sender: Any) {
        print("TEST")
        let validMove = scoreController?.registerMove(move:cellNumber!)
        if validMove!{
            buttonText.setTitle("X", for: .normal)
        }
    }
    
    func autoPressCell(char : Character){
        buttonText.setTitle(String(char), for: .normal)
    }
    
    func autoPressCellMark(set:Bool){
        print("set",set)
        if set {
            print ("Kleurtje zetten")
            buttonText.backgroundColor =  #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        } else {
            buttonText.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func setup(scoreController: ScoreController, cellNumber: Int){
        self.scoreController = scoreController
        self.cellNumber = cellNumber
    }
}
