//
//  WatsonIntegration.swift
//  RiR_POC
//
//  Created by Lucas Torquato on 21/06/19.
//  Copyright © 2019 Torquato. All rights reserved.
//

import Foundation
import TextToSpeech

class WatsonIntegration: NSObject {
    
    //////////////////////////
    // MARK: - Text to Speech
    //////////////////////////

    func requestWatsonToTextToSpeech(text: String, completion: @escaping (_ data: Data?) -> Void) {
        let watUser = "a66a8391-6cab-4a1c-9a04-055553051c68"
        let warPass = "Qlbe3ujGVVMT"
        let textToSpeech = TextToSpeech(username: watUser, password: warPass)
        
        let voice = "pt-BR_IsabelaVoice"
        
        textToSpeech.synthesize(text: text, voice: voice,accept: "audio/wav") { data, error in
            DispatchQueue.main.async {
                completion(data?.result)
            }
        }
    }
    
    func playSound(data: Data?) {
        if let sound = data { //, self.isEnableToPlaySound {
            SoundManager.shared.stopSound()
            SoundManager.shared.setupSound()
            
            SoundManager.shared.playSound(withData: sound)
        }
    }
    
}
