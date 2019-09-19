//
//  MainPageViewController.swift
//  FlashcardMaker
//
//  Created by Derek Burrola on 9/18/19.
//  Copyright © 2019 Derek Burrola. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

     //---------------------
      // Questions & Answers
      //---------------------

    
    // Exam segement for nutrition
    @IBOutlet weak var examSegments: UISegmentedControl!
    // An array that holds an array; used to hold shuffled question and answer arrays
    var qAndA = [Array<String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets up the question and answers array
        qAndA = randomizeArrays(nutrition_q1, nutrition_a1)
    
    }
    
    //---------------------
    //Non-Button functions
    //---------------------
    
    /* Takes in an integer and switches the exam based on that int */
    func changeExamQuestion(_ exam: Int){
        switch exam {
        case 0:
            qAndA = randomizeArrays(nutrition_q1, nutrition_a1)
            break
        case 1:
            qAndA = randomizeArrays(nutrition_q2, nutrition_a2)
            break
        case 2:
            qAndA = randomizeArrays(nutrition_q3, nutrition_a3)
            break
        default:
            qAndA = randomizeArrays(nutrition_q1, nutrition_a1)
            break
        }
    }
    
    //---------------------
    //Button functions
    //---------------------
    
    /* Segment Switches value changes */
    @IBAction func examChangeButton(_ sender: UISegmentedControl) {
        changeExamQuestion(sender.selectedSegmentIndex)
    }
    

    
    //---------------------
    // Segues
    //---------------------
    
    @IBAction func toQuestions(_ sender: Any) {
        print("going to segue")
        performSegue(withIdentifier: "maintoQuestions", sender: self)
    }
    
    @IBAction func toSettings(_ sender: Any) {
        performSegue(withIdentifier: "mainToSettings", sender: self)
    }
    
    /* overrides the prepare for seugues function to pass data to the other screen */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // sets up the controller based on the destination of viewController
        let vc = segue.destination as! ViewController
        // send all relevant information to viewController
        vc.qAndA = qAndA
    }
}
