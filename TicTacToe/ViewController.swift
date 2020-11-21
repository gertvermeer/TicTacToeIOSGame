//
//  ViewController.swift
//  Sudoko2
//
//  Created by Vermeer on 10/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    let colorData  = [ #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        winLine.backgroundColor = .clear
        winLine.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    var  scorecontroller : ScoreController = ScoreController()
    
    @IBOutlet weak var winLine: WinLine!
    
    @IBOutlet weak var message: UILabel!
    
 
    @IBAction func newGame(_ sender: Any) {
        scorecontroller.newGame()
    }
    
    @IBOutlet weak var playerStartSet: UISwitch!
    
//    @IBOutlet weak var playerStartSet: UISwitch!
//
//    @IBAction func playerStartAction(_ sender: Any) {
//        scorecontroller.setPlayerStart(setting: playerStartSet.isOn)
//    }

    @IBAction func playerStartAction(_ sender: Any) {
        scorecontroller.setPlayerStart(setting: playerStartSet.isOn)
    }
}

extension ViewController: UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        scorecontroller.setup(label: message, playStart: (playerStartSet != nil), winLine:winLine)
        message.text = "Veel plezier"
        
        collectionView.bringSubviewToFront(winLine)
        
        return 9
    }
    
     
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigCell", for: indexPath) as! blockCollectionView
        cell.layer.borderWidth=2.0
        cell.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        cell.backgroundColor = .purple
        cell.setup(scoreController: scorecontroller,cellNumber:indexPath.item)
        scorecontroller.addCollectionView(collectionView: cell)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns:CGFloat = 3
        let colwidth: CGFloat = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let space = flowLayout.minimumInteritemSpacing * (columns-1)
        let adjustwith = colwidth-space
        let width:CGFloat = floor(adjustwith/columns)
        return CGSize(width: width, height:width)
    }
    
    
}

