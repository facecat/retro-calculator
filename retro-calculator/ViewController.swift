//
//  ViewController.swift
//  retro-calculator
//
//  Created by 邱国邦 on 15/12/12.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty
    }
    
    //MARK: Outlets
    @IBOutlet weak var ouputLabel: UILabel!
    
    //MARK: Properties
    var btnSound: AVAudioPlayer!
    var runningNum = "" //正在输入的数字
    var leftNum = "0"   //in case the user first press an operator.
    var rightNum = ""
    var resultNum = ""   //  leftNum + rightNum = resutlNum
    var currentOperation = Operation.Empty
    
    //MARK: I don't know how to call this.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Prepare for AVAudioPlayer
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()  //??
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    //MARK: Actions
    @IBAction func numButtonPressed(sender: UIButton!) {
        playBtnSound()
        
        runningNum += "\(sender.tag)"
        ouputLabel.text = runningNum
    }
    
    @IBAction func addButtonPressed(sender: UIButton!) {
        operationPressed(Operation.Add)
    }
    
    @IBAction func subtractButtonPressed(sender: UIButton!) {
        operationPressed(Operation.Subtract)
    }
    
    @IBAction func multiplyButtonPressed(sender: UIButton!) {
        operationPressed(Operation.Multiply)
    }
    
    @IBAction func divideButtonPressed(sender: UIButton!) {
        operationPressed(Operation.Divide)
    }
    
    @IBAction func equalButtonPressed(sender: UIButton!) {
        operationPressed(Operation.Empty)
    }
    
    //MARK: Functions
    func operationPressed(op: Operation) {
        playBtnSound()
        
        //user tab a operator, and tab anothor one with out press an num button.
        if runningNum != "" {
            
            print("running num is not empty")

            if currentOperation != Operation.Empty {
                //Do the math
                
                rightNum = runningNum
                
                if currentOperation == Operation.Add {
                    
                    resultNum = "\(Double(leftNum)! + Double(rightNum)!)"
                }
                if currentOperation == Operation.Subtract {
                    
                    resultNum = "\(Double(leftNum)! - Double(rightNum)!)"
                }
                if currentOperation == Operation.Multiply {
                    
                    resultNum = "\(Double(leftNum)! * Double(rightNum)!)"
                }
                if currentOperation == Operation.Divide {
                    
                    resultNum = "\(Double(leftNum)! / Double(rightNum)!)"
                }
                
                leftNum = resultNum
                ouputLabel.text = resultNum
                
            }
            else {
                leftNum = runningNum    // it this right?
            }
            
            runningNum = ""
        }
        
        currentOperation = op

    }
    
    func playBtnSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

