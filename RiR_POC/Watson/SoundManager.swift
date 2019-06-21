//
//  SoundManager.swift
//  RiR_POC
//
//  Created by Lucas Torquato on 21/06/19.
//  Copyright © 2019 Torquato. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

protocol SoundManagerDelegate: class {
    func didFinishAudioPlaying()
}

final class SoundManager: NSObject {
    
    //////////////////////////
    // MARK: - Properties
    //////////////////////////
    
    private var audioPlayers = [AVAudioPlayer]()
    
    weak var delegate: SoundManagerDelegate?
    
    //////////////////////////
    // MARK: - Initializers
    //////////////////////////
    
    private override init() {
        super.init()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.changeAudioOutput),
                                               name: NSNotification.Name.AVAudioEngineConfigurationChange,
                                               object: nil)
    }
    
    public static let shared: SoundManager = {
        return SoundManager()
    }()
    
    //////////////////////////
    // MARK: - Methods
    //////////////////////////
    
    public func playSound(withData data: Data) {
        do {
            let audioPlayer = try AVAudioPlayer(data: data)
            self.audioPlayers.append(audioPlayer)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.delegate = self
        } catch {
            print("Error playing sound file")
        }
    }
    
    public func stopSound() {
        self.audioPlayers.forEach { (audioPlayer) in
            audioPlayer.stop()
        }
        self.audioPlayers.removeAll()
    }
    
    public func verifyOutput() {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        currentRoute.outputs.forEach { (outputPort) in
            
            print("Port Name: \(outputPort.portName)")
            print("Port Type: \(outputPort.portType)")
            
            switch outputPort.portType {
            case AVAudioSession.Port.headphones,
                 AVAudioSession.Port.carAudio,
                 AVAudioSession.Port.bluetoothLE,
                 AVAudioSession.Port.bluetoothHFP,
                 AVAudioSession.Port.bluetoothA2DP:
                do {
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                } catch { }
            default:
                do {
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                } catch { }
            }
        }
        
    }
    
    @objc public func changeAudioOutput() {
        self.verifyOutput()
    }
    
    public func setupSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: [AVAudioSession.CategoryOptions.allowAirPlay, AVAudioSession.CategoryOptions.allowBluetooth, AVAudioSession.CategoryOptions.allowBluetoothA2DP])            
            self.verifyOutput()
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            // do nothing
        }
    }
}

///////////////////////////////
// MARK: - AVAudioPlayerDelegate
///////////////////////////////

extension SoundManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.delegate?.didFinishAudioPlaying()
    }
}

