//
//  CreateViewController.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    private var quizTitlePlaceholder = "Title"
    private var quizFact1Placeholder = "Please enter first fact"
    private var quizFact2Placeholder = "Please enter second fact"
    @IBOutlet weak var quizTitleTextView: UITextView!
    
    @IBOutlet weak var quizFact1TextView: UITextView!
    
    @IBOutlet weak var quizFact2TextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextViews()
        quizTitleTextView.becomeFirstResponder()
    }
    private func setupTextViews() {
        quizTitleTextView.delegate = self
        quizFact1TextView.delegate = self
        quizFact2TextView.delegate = self
        quizTitleTextView.text = quizTitlePlaceholder
        quizFact1TextView.text = quizFact1Placeholder
        quizFact2TextView.text = quizFact2Placeholder

        quizTitleTextView.textColor = .lightGray
        quizFact1TextView.textColor = .lightGray
        quizFact2TextView.textColor = .lightGray

    }
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        guard let quizTitle = quizTitleTextView.text,
            let quizFact1 = quizFact1TextView.text, let quizFact2 = quizFact2TextView.text else {
                fatalError("title, description nil")
        }
        
        // timestamp base on the current time
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        let timestamp = isoDateFormatter.string(from: date)
        
        // create an item
        let aQuiz = FavoriteQuiz.init(quizTitle: quizTitle, fact1: quizFact1, fact2: quizFact2, createdAt: timestamp)
        // save item to documents directory
       QuizModel.addQuiz(quiz: aQuiz)
        showAlert(title: "Quiz Added", message: "Successfully added quiz")
        print(QuizModel.getQuiz())
        dismiss(animated: true, completion: nil)
    }
    
}
extension CreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if quizTitleTextView.text == quizTitlePlaceholder {
            textView.text = ""
            textView.textColor = .black
        }
        if quizFact1TextView.text == quizFact1Placeholder {
            textView.text = ""
            textView.textColor = .black
        }
        if quizFact2TextView.text == quizFact2Placeholder {
            textView.text = ""
            textView.textColor = .black
        }

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            if textView == quizTitleTextView || textView == quizFact1TextView ||  textView == quizFact2TextView {
                if textView == quizTitleTextView {
                    textView.text = quizTitlePlaceholder
                    textView.textColor = .lightGray
                } else if textView == quizFact1TextView {
                    textView.text = quizFact1Placeholder
                    textView.textColor = .lightGray
                } else if textView == quizFact2TextView {
                    textView.text = quizFact2Placeholder
                    textView.textColor = .lightGray
                }
            }
        }
    }
}
