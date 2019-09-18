//
//  MainPageViewController.swift
//  FlashcardMaker
//
//  Created by Derek Burrola on 9/18/19.
//  Copyright © 2019 Derek Burrola. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func toQuestions(_ sender: Any) {
        print("going to segue")
        performSegue(withIdentifier: "toQuestions", sender: self)
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
