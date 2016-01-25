//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by mohamed elrashid on 11/23/15.
//  Copyright © 2015 Mohamed Elrashid. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController ,AVAudioRecorderDelegate    {
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    var isPause:Bool!
    
    @IBOutlet weak var recodingStatues: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()       
    }
    
    override  func viewWillAppear(animated: Bool) {
       changeUIToStopStatues()
    }
    
    func  changeUIToPauseStatues(){
        recordButton.hidden = false
        stopButton.hidden  = true
        pauseButton.hidden = true
        recodingStatues.text =
        "Tap to resume Recording"
         isPause = true
    }
    
    func  changeUIToRecordingStatues(){
        recordButton.hidden = true
        stopButton.hidden  = false
        pauseButton.hidden = false
        recodingStatues.text =
        "Recording …"
         isPause = false
    }
    
    func  changeUIToStopStatues(){
        recordButton.hidden = false
        stopButton.hidden  = true
        pauseButton.hidden = true
        recodingStatues.text =
        "Tap to Record"
       isPause = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func pauseRecording(sender: UIButton) {
        audioRecorder.pause()
        changeUIToPauseStatues()
    }

    @IBAction func recordAudio(sender: UIButton) {
    
        
        if ( isPause == true) {
            audioRecorder.record()
        }
        else
        {
       
        let dirPath = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory,
            .UserDomainMask,
             true)[0]as String

        let recordingName = "my_audio.wav"
        
        let pathArray = [dirPath, recordingName]
        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        
        audioRecorder.meteringEnabled = true
        
        audioRecorder.prepareToRecord()
        
        audioRecorder.record()
        }
        
           changeUIToRecordingStatues()
    }

    @IBAction func stopRecording(sender: UIButton) {
        
        changeUIToStopStatues()
        
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(
                    recorder: AVAudioRecorder,
                    successfully flag: Bool)
    {
        if(flag){
            recordedAudio =
                RecordedAudio(_filePathUrl: recorder.url,
                    _title: recorder.url.lastPathComponent!)
            
            
            self.performSegueWithIdentifier(
                "stopRecording",
                sender: recordedAudio)
            
        }else{
           changeUIToStopStatues()
        }
        
        
    }
    
    override func prepareForSegue(
                    segue: UIStoryboardSegue,
                    sender: AnyObject?)
    {
        
        if(segue.identifier == "stopRecording")
            {
        
                let playSoundsVC:RemixViewController =
                    segue.destinationViewController
                    as! RemixViewController
            
                let data = sender
                    as! RecordedAudio
            
                playSoundsVC.receivedAudio = data
            
        }
    }
    
}
