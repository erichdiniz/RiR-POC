//
//  MapsViewController.swift
//  RiR_POC
//
//  Created by Erich Diniz on 24/06/19.
//  Copyright © 2019 Erich Diniz. All rights reserved.
//

import UIKit

class MapsViewController: UIViewController {

    @IBOutlet weak var mapImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Map Image
        switch Device.version() {
        case .iPhone6Plus, .iPhone7Plus, .iPhone8Plus:
            self.mapImage.contentMode = .scaleToFill
        case .iPhone6, .iPhone7, .iPhone8, .iPhone6S:
            self.mapImage.contentMode = .top
        default:
            self.mapImage.contentMode = .scaleAspectFit
        }
    }
    
    @IBAction func didTouchCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
