//
//  Connected3ViewController.swift
//  RiR_POC
//
//  Created by Erich Diniz on 23/06/19.
//  Copyright © 2019 Erich Diniz. All rights reserved.
//

import UIKit

class Connected3ViewController: UIViewController {
    private let connected = ConnectedViewController()
    
    @IBOutlet weak var lblQuestion3: UILabel!
    @IBOutlet weak var btnNext3: UIButton!
    @IBOutlet weak var imgFreq: UIImageView!
    @IBOutlet weak var imgAnswer3: UIImageView!
    @IBOutlet weak var imgAnswer3b: UIImageView!
    @IBOutlet weak var btnAgendar: UIButton!
    @IBOutlet weak var lblAnswer3: UILabel!
    @IBOutlet weak var lblAnswer3b: UILabel!
    @IBOutlet weak var imgOv1: UIImageView!
    @IBOutlet weak var imgOv2: UIImageView!
    @IBOutlet weak var imgOv3: UIImageView!
    @IBOutlet weak var imgOv4: UIImageView!
    @IBOutlet weak var imgOv5: UIImageView!
    
    private let watsonIntegration = WatsonIntegration()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnAgendar?.layer.cornerRadius = 24
        btnAgendar?.clipsToBounds = true
        btnNext3?.layer.cornerRadius = 24
        btnNext3?.clipsToBounds = true
        // Do any additional setup after loading the view.
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
                lblQuestion3?.isHidden = false
                
                self.watsonIntegration.requestWatsonToTextToSpeech(text: self.lblAnswer3.text ?? "", completion: { (data) in
                    if let data = data {
                        SoundManager.shared.playSound(withData: data)
                    }
                    self.lblAnswer3?.isHidden = false
                    self.lblAnswer3b.isHidden = false
                    self.btnAgendar.isHidden = false
                    self.imgAnswer3b.isHidden = false
                    self.imgAnswer3.isHidden = false
                    self.btnNext3?.isHidden = true
                    self.imgOv1?.isHidden = false
                    self.imgOv2?.isHidden = false
                    self.imgOv3?.isHidden = false
                    self.imgOv4?.isHidden = false
                    self.imgOv5?.isHidden = false

                    
                })
                
            }
            else
            {
                button.setImage(UIImage(named: "microphone"), for: .highlighted)
                button.setImage(UIImage(named: "microphone"), for: [])
                imgFreq.image = UIImage(named: "voice_stop")
                lblQuestion3?.isHidden = true
                btnNext3?.isHidden = false
                imgAnswer3?.isHidden = true
                self.lblAnswer3?.isHidden = true
                self.lblAnswer3b.isHidden = true
                self.btnAgendar.isHidden = true
                self.imgAnswer3b.isHidden = true
                self.imgOv1?.isHidden = true
                self.imgOv2?.isHidden = true
                self.imgOv3?.isHidden = true
                self.imgOv4?.isHidden = true
                self.imgOv5?.isHidden = true
            }
        }
    }
    
    
    @IBAction func dismissAll(_ sender: Any) {
        //        self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        //        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }


    @IBAction func agendado (_ sender : Any){
        let alertController = UIAlertController(title: "Agendado!", message:
            "Sua atração foi agendada com sucesso!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
