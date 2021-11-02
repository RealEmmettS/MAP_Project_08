//
//  ViewController.swift
//  Xylophone
//
//  Created by Emmett Shaughnessy on 10/21/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    
    var allButtons:[UIButton] = []
    var player: AVAudioPlayer!
    
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allButtons = [cButton, dButton, eButton, fButton, gButton, aButton, bButton]
        
      
    }
    
    
    //MARK: Color Similarity Test
    override func viewDidAppear(_ animated: Bool) {
        
        
        similarityTest()
        
    }//end of viewDidAppear()
    
    
    //MARK: - Xylophone Taps
    @IBAction func cTapped(_ sender: Any) {
        playSound(.C)
        cButton.titleLabel?.textColor = cButton.backgroundColor?.inverseColor()
        //view.backgroundColor = cButton.backgroundColor
    }
    @IBAction func dTapped(_ sender: Any) {
        playSound(.D)
        dButton.titleLabel?.textColor = dButton.backgroundColor?.inverseColor()
        //view.backgroundColor = dButton.backgroundColor
    }
    @IBAction func eTapped(_ sender: Any) {
        playSound(.E)
        eButton.titleLabel?.textColor = eButton.backgroundColor?.inverseColor()
        //view.backgroundColor = eButton.backgroundColor
    }
    @IBAction func fTapped(_ sender: Any) {
        playSound(.F)
        fButton.titleLabel?.textColor = fButton.backgroundColor?.inverseColor()
        //view.backgroundColor = fButton.backgroundColor
    }
    @IBAction func gTapped(_ sender: Any) {
        playSound(.G)
        gButton.titleLabel?.textColor = gButton.backgroundColor?.inverseColor()
        //view.backgroundColor = gButton.backgroundColor
    }
    @IBAction func aTapped(_ sender: Any) {
        playSound(.A)
        aButton.titleLabel?.textColor = aButton.backgroundColor?.inverseColor()
        //view.backgroundColor = aButton.backgroundColor
    }
    @IBAction func bTapped(_ sender: Any) {
        playSound(.B)
        bButton.titleLabel?.textColor = bButton.backgroundColor?.inverseColor()
        //view.backgroundColor = bButton.backgroundColor
    }
    
    
    
    //MARK: Audio Player
    func playSound(_ noteToPlay:note) {
        var finalNote:String
        
        switch noteToPlay {
        case .A:
            finalNote = "A"
        case .B:
            finalNote = "B"
        case .C:
            finalNote = "C"
        case .D:
            finalNote = "D"
        case .E:
            finalNote = "E"
        case .F:
            finalNote = "F"
        case .G:
            finalNote = "G"
        }//end of switch
        
        print("Played Note: \(finalNote)")
        let url = Bundle.main.url(forResource: finalNote, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                  
      }// end of playSound()
    
    //MARK: Similarity Test
    func similarityTest(){
        
        var simCount = 1
        let maxSimTests = 50000
        
        
        let modifyList:[UIButton] = [cButton, dButton, eButton, fButton, gButton, aButton, bButton]
        for button in modifyList {
            button.backgroundColor = .red
        }
        
        
        var lastColor:[RGB_Color] = [RGB_Color(r: 0, g: 0, b: 0)]
        var count = 1
        for button in allButtons{
            print("Button \(count)")

            var currentColor = randomColor()
            var similarity = displayScoreAsPercent(baseColor: currentColor, matchArray: lastColor)
            if similarity >= 20 {
                
                while similarity >= 20{
                    let simHighScore = defaults.integer(forKey: "simCountHighScore")
                    if simHighScore == nil {
                        defaults.set(0, forKey: "simCountHighScore")
                    }
                    if simCount > simHighScore{
                        defaults.set(simCount, forKey: "simCountHighScore")
                    }
                    print("Similarity loop iteration \(simCount). Current high score is \(simHighScore)")
                    currentColor = randomColor()
                    similarity = displayScoreAsPercent(baseColor: currentColor, matchArray: lastColor)
                    simCount += 1
                    if simCount > maxSimTests{
                        break
                    }
                }
            }
            
            if simCount > maxSimTests{
                break
            }

            button.backgroundColor = currentColor.UIColor()
            button.setTitleColor(button.backgroundColor?.inverseColor(), for: .normal)
            button.tintColor = button.backgroundColor?.inverseColor()
            lastColor.append(currentColor)

            count += 1
            print("––––––––––––––––––––––––––––")
        }
        
        if simCount > maxSimTests{
            print("\n\n")
            print("––––––––––––––––––––––––––––")
            print("RESTARTING SIMILARITY TEST")
            print("––––––––––––––––––––––––––––")
            print("\n\n")
            similarityTest()
        }
        
    }

    
}//end of viewController()






extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

