//
//  NotConnectedViewController.swift
//  RiR_POC
//
//  Created by Erich Diniz on 17/06/19.
//  Copyright © 2019 Erich Diniz. All rights reserved.
//

import UIKit

enum ResponseType {
    case normal
    case schedule
    case images
    case maps
}

class ConnectedViewController: UIViewController {

    var imageNames = ["drake","cardib", "rexha", "alok"]
    
    var watsonMocks: [WatsonMock] = WatsonMock.createMocks()
    var indexMock: Int = 0
    
    @IBOutlet weak var ok_social: UIImageView!
    @IBOutlet weak var gambiarraView: UIView!
    
    @IBOutlet weak var btnTwoSeven: UIButton!
    @IBOutlet weak var btnTwoEight: UIButton!
    @IBOutlet weak var btnTwoNine: UIButton!
    @IBOutlet weak var btnThreeTen: UIButton!
    @IBOutlet weak var btnFourTen: UIButton!
    @IBOutlet weak var btnFiveTen: UIButton!
    @IBOutlet weak var btnSixTen: UIButton!
    
    @IBOutlet weak var imgFreq: UIImageView!
    @IBOutlet weak var lblQuestion1: UILabel!
    @IBOutlet weak var lblAnswer1: UILabel!
    @IBOutlet weak var btnQuestion1: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!

    @IBOutlet weak var btnTwoSevenStage: UIButton!
    @IBOutlet weak var btnFourTenStage: UIButton!
    @IBOutlet weak var btnSixTenStage: UIButton!
    
    @IBOutlet weak var btnMic: UIButton!
    private let watsonIntegration = WatsonIntegration()
    
    let btnColorDeselected = UIColor(rgb: 0x3C134C)
    let btnColorSelected = UIColor(rgb: 0xE64484)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mockImageView: UIImageView!
    
    var isFinished: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        
        btnTwoSevenStage?.layer.cornerRadius = 24
        btnTwoSevenStage?.clipsToBounds = true
        btnFourTenStage?.layer.cornerRadius = 24
        btnFourTenStage?.clipsToBounds = true
        btnSixTenStage?.layer.cornerRadius = 24
        btnSixTenStage?.clipsToBounds = true
        
        btnNext?.layer.cornerRadius = 24
        btnNext?.clipsToBounds = true

        
        btnTwoSeven?.layer.cornerRadius = 24
        btnTwoSeven?.clipsToBounds = true
        btnTwoSeven?.layer.cornerRadius = 24
        btnTwoSeven?.clipsToBounds = true
        btnTwoEight?.layer.cornerRadius = 24
        btnTwoEight?.clipsToBounds = true
        btnTwoNine?.layer.cornerRadius = 24
        btnTwoNine?.clipsToBounds = true
        btnThreeTen?.layer.cornerRadius = 24
        btnThreeTen?.clipsToBounds = true
        btnFourTen?.layer.cornerRadius = 24
        btnFourTen?.clipsToBounds = true
        btnFiveTen?.layer.cornerRadius = 24
        btnFiveTen?.clipsToBounds = true
        btnSixTen?.layer.cornerRadius = 24
        btnSixTen?.clipsToBounds = true
        
        btnQuestion1?.layer.cornerRadius = 24
        btnQuestion1?.clipsToBounds = true
        
        mockImageView?.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isFinished {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        if let button : UIButton = sender as? UIButton {
            button.isSelected = !button.isSelected
            
            if (button.isSelected) {

                button.backgroundColor = btnColorDeselected
                button.setTitleColor(UIColor.white, for: .normal)
                button.tintColor = btnColorDeselected
                //To change button Title colour .. check your button Tint color is clear_color..

            } else {

                button.backgroundColor = btnColorSelected
                button.setTitleColor(UIColor.white, for: .normal)
                button.layer.borderColor = btnColorSelected.cgColor
                button.tintColor = btnColorSelected
//                button.layer.border//To change button Title colour .. check your button Tint color is clear_color..

            }
        }
    }
    
    @IBAction func btnMicPressed(_ button: UIButton) {
        SoundManager.shared.stopSound()
        button.isSelected = !button.isSelected
        
        if (button.isSelected) {
            let watsonMock = self.watsonMocks[self.indexMock]
            
            button.setImage(UIImage(named: "microphone_selected"), for: .focused)
            button.setImage(UIImage(named: "microphone_selected"), for: .selected)
            //let voiceRecordingGif = UIImage.gifImageWithName("freq_recording_v1")
            gambiarraView.isHidden = false
            let recordingImage = UIImage.gifImageWithName("freq_recording_v1")
            imgFreq.alpha = 1
            
            
            imgFreq.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)

            imgFreq.image = recordingImage
            
            lblQuestion1.text = watsonMock.questionText
            lblQuestion1.isHidden = false
            lblAnswer1.text = watsonMock.responseText
            lblAnswer1.sizeToFit()
            
            if watsonMock.responseType == .normal || watsonMock.responseType == .schedule {
                
                self.btnMic.isEnabled = false
                self.watsonIntegration.requestWatsonToTextToSpeech(text: self.lblAnswer1.text ?? "", completion: { (data) in
                    if let data = data {
                        SoundManager.shared.playSound(withData: data)
                    }
                    self.lblAnswer1.isHidden = false
                    self.btnQuestion1.isHidden = false
                    
                    button.setImage(UIImage(named: "microphone"), for: .selected)
                    self.imgFreq.image = UIImage(named: "voice_stop")
                    self.btnMic.isEnabled = true
                })
                
            } else if watsonMock.responseType == .images {
                
                self.watsonIntegration.requestWatsonToTextToSpeech(text: self.lblAnswer1.text ?? "", completion: { (data) in
                    if let data = data {
                        SoundManager.shared.playSound(withData: data)
                    }
                    self.mockImageView.isHidden = false
                    self.lblAnswer1.isHidden = true
                    self.btnQuestion1.isHidden = true
                    
                    button.setImage(UIImage(named: "microphone"), for: .selected)
                    self.imgFreq.image = UIImage(named: "voice_stop")
                    self.btnMic.isEnabled = true
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.btnQuestion1.isHidden = true
                    self.imgFreq.isHidden = true
                    self.lblAnswer1.isHidden = true
                    }
                
            } else if watsonMock.responseType == .maps {
                
                self.watsonIntegration.requestWatsonToTextToSpeech(text: self.lblAnswer1.text ?? "", completion: { (data) in
                    if let data = data {
                        SoundManager.shared.playSound(withData: data)
                    }
                    
                    
                    // Returns an animated UIImage
//                    let freqGif = UIImage.gifImageWithName("freq_recording_v1")
                    
                    // Use the UIImage in your UIImageView
//                    let imageView = UIImageView(image: FreqGif)
                    button.setImage(UIImage(named: "microphone"), for: .selected)
                    self.imgFreq.image = UIImage.gifImageWithName("freq_recording_v1")
                    self.lblAnswer1.isHidden = true
                    
                })
                
                self.lblQuestion1.isHidden = false
                self.mockImageView.isHidden = true
                self.lblAnswer1.isHidden = true
                
                self.isFinished = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.performSegue(withIdentifier: "presentMaps", sender: nil)
                }
            }
            
        } else {
            
            gambiarraView.isHidden = false
            button.setImage(UIImage(named: "microphone"), for: .highlighted)
            button.setImage(UIImage(named: "microphone"), for: [])
            imgFreq.image = UIImage(named: "voice_stop")
            lblQuestion1.isHidden = true
            lblAnswer1.isHidden = true
            btnQuestion1.isHidden = true
            mockImageView.isHidden = true
//            btnNext1.isHidden = true
            
            self.indexMock = self.indexMock + 1
        }
    }
    
    @IBAction func dismissAll(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Agendado!", message:
            "Sua atração foi agendada com sucesso!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.lblQuestion1.isHidden = true
            self.lblAnswer1.isHidden = true
            self.btnQuestion1.isHidden = true
            self.btnQuestion1.alpha = 0
        //}

        SoundManager.shared.stopSound()
    }
    
    @IBAction func socialConnect(_ button: UIButton){
        button.isSelected = !button.isSelected
        
        if (button.isSelected) {
            ok_social.isHidden = false
            
        } else {
            
            ok_social.isHidden = true
        }
    }
}



extension ConnectedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "singerCell", for: indexPath) as? SingersTableViewCell else {
            return UITableViewCell()
        }
        
        let imageName = imageNames[indexPath.row]
        cell.singerImageView.image = UIImage(named: imageName)
        cell.selectionStyle = .none
        return cell
    }
}
    
    extension UIColor {
        convenience init(red: Int, green: Int, blue: Int) {
            assert(red >= 0 && red <= 255, "Invalid red component")
            assert(green >= 0 && green <= 255, "Invalid green component")
            assert(blue >= 0 && blue <= 255, "Invalid blue component")
            
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }
        
        convenience init(rgb: Int) {
            self.init(
                red: (rgb >> 16) & 0xFF,
                green: (rgb >> 8) & 0xFF,
                blue: rgb & 0xFF
            )
        }
}
