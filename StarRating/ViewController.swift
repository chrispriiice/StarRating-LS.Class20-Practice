//
//  ViewController.swift
//  StarRating
//
//  Created by Chris Price on 4/16/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
    
        if ratingControl.value == 1 {
            title = "User Rating: 1 Star"
        } else {
            title = "User Rating: \(ratingControl.value) Stars"
        }
    }
}

