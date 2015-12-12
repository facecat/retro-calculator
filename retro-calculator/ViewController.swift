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
    
    //MARK: Outlets
    @IBOutlet weak var ouputLabel: UILabel!
    
    //MARK: Properties
    var btnSound: AVAudioPlayer!
    var runningNum = "" //显示在屏幕上的数字
    
    
    //MARK: I don't know how to call this.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Prepare for AVAudioPlayer
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
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
    
    //MARK: Functions
    func playBtnSound() {
        btnSound.play()
    }
}

