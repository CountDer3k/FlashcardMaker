//
//  MainPageViewController.swift
//  FlashcardMaker
//
//  Created by Derek Burrola on 9/18/19.
//  Copyright © 2019 Derek Burrola. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Exam segement for nutrition
    @IBOutlet weak var examSegments: UISegmentedControl!
    // An array that holds an array; used to hold shuffled question and answer arrays
    var qAndA = [Array<String>]()
    
    @IBOutlet weak var nutritionLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var questionPicker: UIPickerView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Sets background color and text
        view.backgroundColor = currentColor
        nutritionLabel.textColor = currentTextColor
        readFile()
        // Sets up the picker
        if(questionsListArray.count == 0){
            // Loads up the hardcoded answer, if nothing is downlaoded
            questionTitleList.removeAll()
            questionTitleList.append("Nutrition 1")
            // Sets up the question and answers array
            qAndA = randomizeArrays(nutrition_q1, nutrition_a1)
        }
        else{
            // Something has been downloaded
            hasTextFile = 0
            qAndA = randomizeArrays(questionsListArray[hasTextFile], answersListArray[hasTextFile])
        }
        
    }
    
    //---------------------
    //Non-Button functions
    //---------------------
    
    
    //---------------------
    // UI Picker View
    //---------------------
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return questionTitleList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return questionTitleList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Code
        if(questionsListArray.count != 0){
            hasTextFile = row
            qAndA = randomizeArrays(questionsListArray[hasTextFile], answersListArray[hasTextFile])
        }
    }
    
    //---------------------
    //Button functions
    //---------------------
    

    
    //---------------------
    // Segues
    //---------------------
    
    @IBAction func toQuestions(_ sender: Any) {
        performSegue(withIdentifier: "maintoQuestions", sender: self)
    }
    
    @IBAction func toSettings(_ sender: Any) {
        performSegue(withIdentifier: "mainToSettings", sender: self)
    }
    
    /* overrides the prepare for seugues function to pass data to the other screen */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "mainToSettings" {
            let sc = segue.destination as! SettingsController
            sc.lastCaller = "Main"
        }
        else{
            // sets up the controller based on the destination of viewController
            let vc = segue.destination as! ViewController
            // send all relevant information to viewController
            vc.qAndA = qAndA
        }
    }
}
