//
//  RemixViewController.swift
//  Pitch Perfect
//
//  Created by mohamed elrashid on 11/23/15.
//  Copyright © 2015 Mohamed Elrashid. All rights reserved.
//

import UIKit
import AVFoundation

class RemixViewController: UIViewController , AVAudioPlayerDelegate {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        audioPlayer  = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        
        audioPlayer.enableRate = true
        
        audioPlayer.delegate = self
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        stopButton.hidden = true
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
   
    
    @IBAction func playSlow(sender: UIButton) {
        
            resetAudio()
        
            stopButton.hidden = false
        
            playAudioWithVariableSpeed(0.5)
        
         }
    
    
    @IBAction func playFast(sender: UIButton) {
        
        resetAudio()
        
        stopButton.hidden = false
        
        playAudioWithVariableSpeed(1.5)
        
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        
        resetAudio()
        
        stopButton.hidden = false
        
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        resetAudio()
        
        stopButton.hidden = false
        
        playAudioWithVariablePitch(-1000)
       
    }
   
    @IBAction func playEcho(sender: UIButton) {
        
        resetAudio()
        
        stopButton.hidden = false
        
        playAudioWithEcho()

    }
    
    
    @IBAction func stopPlaying(sender: UIButton) {
        
       resetAudio()
        
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
         stopButton.hidden = true
        
    }
    
  
    func resetAudio() {
        
        audioPlayer.stop()
        
        audioEngine.stop()
        
        audioEngine.reset()
        
        audioPlayer.currentTime = 0
        
        stopButton.hidden = true
        
    }
    
    func   playAudioWithVariableSpeed( speed:Float){
        
        audioPlayer.rate = speed
        
        audioPlayer.play()
        
    }
    
    func  playAudioWithVariablePitch( myptich:Float){
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        
        changePitchEffect.pitch = myptich
        
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler:{
            self.stopButton.hidden = true
        } )
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
    func   playAudioWithEcho(){
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioEngine.attachNode(audioPlayerNode)
        
        let echoEffect = AVAudioUnitDelay();
        
        echoEffect.delayTime = NSTimeInterval(0.3)
        
        audioEngine.attachNode(echoEffect)
        
        audioEngine.connect(audioPlayerNode, to: echoEffect, format: nil)
        
        audioEngine.connect(echoEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: {
            self.stopButton.hidden = true
            })
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
}
