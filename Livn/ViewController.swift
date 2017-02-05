//
//  ViewController.swift
//  Livn
//
//  Created by Brylan Donaldson on 2/1/17.
//  Copyright © 2017 LivnInc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "goToLoginScreen", sender: self)
        print("Works")
    }
    
}
