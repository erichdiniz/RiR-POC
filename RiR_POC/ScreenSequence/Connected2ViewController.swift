//
//  Connected2ViewController.swift
//  RiR_POC
//
//  Created by Erich Diniz on 19/06/19.
//  Copyright © 2019 Erich Diniz. All rights reserved.
//

import UIKit

class Connected2ViewController: UIViewController {

    @IBOutlet weak var imgFreq: UIImageView!
    @IBOutlet weak var btnMic: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var imgBadge1: UIImageView!
    @IBOutlet weak var lblQuestion2: UILabel!
    @IBOutlet weak var lblAnswer2: UILabel!
    @IBOutlet weak var btnNext2: UIButton!
    @IBOutlet weak var btnNext3: UIButton!
    
    private let watsonIntegration = WatsonIntegration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBadge1?.isHidden = false
        myLabel?.isHidden = true
        btnNext?.isHidden = true
 
        
        btnNext?.layer.cornerRadius = 24
        btnNext?.clipsToBounds = true
        btnNext2?.layer.cornerRadius = 24
        btnNext2?.clipsToBounds = true
        btnNext3?.layer.cornerRadius = 24
        btnNext3?.clipsToBounds = true
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.myLabel?.isHidden = false

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.btnNext?.isHidden = false
            
        }
    }
    
    
    @IBAction func btnMicPressed(_ sender: Any) {
        if let button : UIButton = sender as? UIButton
        {
            button.isSelected = !button.isSelected
            
            if (button.isSelected)
            {
                
                button.setImage(UIImage(named: "microphone_selected"), for: .focused)
                button.setImage(UIImage(named: "microphone_selected"), for: .selected)
                imgFreq.image = UIImage(named: "voice_recording")
                lblQuestion2?.isHidden = false
            
                self.watsonIntegration.requestWatsonToTextToSpeech(text: self.lblAnswer2.text ?? "", completion: { (data) in
                    if let data = data {
                        SoundManager.shared.playSound(withData: data)
                    }
                    self.lblAnswer2?.isHidden = false
                    self.btnNext2?.isHidden = false
                    self.btnNext3?.isHidden = false
                })
            
            }
            else
            {
                button.setImage(UIImage(named: "microphone"), for: .highlighted)
                button.setImage(UIImage(named: "microphone"), for: [])
                imgFreq.image = UIImage(named: "voice_stop")
                lblQuestion2?.isHidden = true
                btnNext2?.isHidden = true
                lblAnswer2?.isHidden = true
            }
        }
    }
    
    
    @IBAction func dismissAll(_ sender: Any) {
        //        self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        //        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }

}

