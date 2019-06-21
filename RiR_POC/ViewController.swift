//
//  ViewController.swift
//  RiR_POC
//
//  Created by Erich Diniz on 17/06/19.
//  Copyright © 2019 Erich Diniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var btnNext: UIButton!
    
    @IBAction func backButton(segue: UIStoryboardSegue,_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnNext?.layer.cornerRadius = 24
        btnNext?.clipsToBounds = true
    }
    
}

