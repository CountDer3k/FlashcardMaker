//
//  ViewController.swift
//  FlashcardMaker
//
//  Created by Derek Burrola on 2/4/19.
//  Copyright © 2019 Derek Burrola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var ProgressLabel: UILabel!
    var qAndA = [Array<String>]()
    var active_Module_q = [""]
    var active_Module_a = [""]
    var randomNumberHolder = -1
    @IBOutlet weak var headingLabel: UILabel?
    var counter = 0
    // holds the total number of questions
    var questionCounter = 0
    var usedRandom = [Int]()
    @IBOutlet weak var answerSlot: UILabel!
    @IBOutlet weak var questionSlotLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Used to know if lists are even when I add a new one (checks questions & answers are equal)
        //print("\(nutrition_q1.count) & \(nutrition_a1.count)")
        
        // Sets up the original list into a temporary list to keep OG list intact
        setupQuestionsAndAnswers()
    }
    
    //-----------------------------
     // Button functions
     //-----------------------------
    
    /* What happens when the 'next' button is pressed */
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        nextQuestion()
    }
    
    /* What happens when the 'answer' button is pressed */
    @IBAction func answerButton(_ sender: Any) {
       showAnswer()
    }
    
    
    /* What happens when the RESET button is pressed */
    @IBAction func ResetQuestions(_ sender: Any) {
        
        // Resets variables
        resetVariable()
        
        // Radomizes the question again
        qAndA = randomizeArrays(qAndA[0], qAndA[1])
        
        // Adds the questions back into memory
        setupQuestionsAndAnswers()
        
        // updates the labels
        ProgressLabel.text = "\(counter)/\(questionCounter)"
        questionSlotLabel.text = "Press 'Next' To Begin"
        answerSlot.text = "???"
    }
    
    
    //---------------------------------------------
    // Non-Button Function (Excluding viewDidLoad()
    //----------------------------------------------

    
    /* Function to keep the question counter on the top right accurate */
    func questionCounterTracker(_ direction: String) {
        if direction == "add"{
            counter = counter + 1
        }
        if direction == "sub"{
            counter = counter - 1
        }
        ProgressLabel.text = "\(counter)/\(questionCounter)"
    }
    
    /* Sets the question back up */
    func setupQuestionsAndAnswers(){
        active_Module_q = qAndA[0]
        active_Module_a = qAndA[1]
        questionCounter = active_Module_q.count
    }
    
    /* Shows the next question on the screen and handles updating all labels */
    func nextQuestion(){
        // Once all questions have been shown
        if counter == active_Module_q.count {
            answerSlot.text = "Finished All Questions"
            questionSlotLabel.text = "Finished All Questions"
        }
        else{
            // Updates the label
            questionCounterTracker("add")
            questionSlotLabel.text = active_Module_q[counter-1]
            headingLabel?.text = "Question #\(counter)"
            answerSlot.text = "???"
        }
    }
    
    func previousQuestion(){
        // If on first question. Don't run the back to prevent out of bound errors
        if counter <= 1{
            answerSlot.text = "???"
        }
        else{
            // Update the labels
            questionCounterTracker("sub")
            questionSlotLabel.text = active_Module_q[counter-1]
            headingLabel?.text = "Question #\(counter)"
            answerSlot.text = "???"
        }
    }
    
//    /* Load Answer into the answer slot */
    func showAnswer(){
        // If program hasn't started, list amount of questions and amount of answers
        if(counter == 0){
            answerSlot.text = "Que:\(active_Module_q.count) Ans:\(active_Module_a.count)"
        }
        // Once all questions have been shown
        if counter == active_Module_q.count {
            answerSlot.text = "Finished All Questions"
            questionSlotLabel.text = "Finished All Questions"
        }
        // Shows answer to current question
        else{
            answerSlot.text = active_Module_a[counter-1]
        }
    }
    
    /* Resets the variables as if the program had just opened */
    func resetVariable(){
        // Resets the question and answer arrays
        active_Module_q = [""]
        active_Module_a = [""]
        // Resets the random number and counters
        randomNumberHolder = -1
        counter = 0
        questionCounter = 0
    }
    
    //-----------------------------
    // Segue events
    //-----------------------------
    
    @IBAction func toMain(_ sender: Any) {
        performSegue(withIdentifier: "questionsToMain", sender: self)
    }
    
    
    //-----------------------------
    // Gestue Events
    //-----------------------------
    
    /* What happens when a user swipes to the left on the answer view */
    @IBAction func SwipeLeft(_ sender: Any) {
        previousQuestion()
    }
    
    /* What happens when a user swipes to the right on the answer view */
    @IBAction func SwipeRight(_ sender: Any) {
        // Runs the next question command
        nextQuestion()
    }
}

