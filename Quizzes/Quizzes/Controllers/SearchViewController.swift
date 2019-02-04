//
//  SearchViewController.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
let searchQuizzesView = SearchQuizzesView()
    var link = SearchViewController?.self
    public func currentIndex(currentIndex: Int) -> Int{
        return currentIndex
    }
    var quiz = [Quiz](){
        didSet{
            DispatchQueue.main.async {
                self.searchQuizzesView.colloectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchQuizzesView)
        searchQuizzesView.colloectionView.register(SearchQuizzesCellCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCell")
        searchQuizzesView.colloectionView.dataSource = self
        getQuiz()
    }
    private func getQuiz(){
        QuizAPIClient.getQuiz{ (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.quiz = data
                
            }
        }
    }
  
}
extension SearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quiz.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchQuizzesCellCollectionViewCell else { return UICollectionViewCell() }
        let quizToSet = quiz[indexPath.row]
       
        cell.label.text = quizToSet.quizTitle
        cell.button.layer.setValue(indexPath.row, forKey: "index")
        cell.button.addTarget(self, action: #selector(favorite), for: .touchUpInside)
        return cell
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
    
    
    @objc public func favorite(sender: UIButton){
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        
        let timestamp = isoDateFormatter.string(from: date)
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        
        self.searchQuizzesView.colloectionView.reloadData()
        guard !QuizModel.isFavorite(quizTitle: (quiz[i].quizTitle))else {
            showAlert(title: "Duplicate", message: "\(quiz[i].quizTitle) already exist in your favorites")
            print(QuizModel.getQuiz())
            return
        }
        let favoriteQuiz = FavoriteQuiz.init(quizTitle: (quiz[i].quizTitle), fact1: (quiz[i].facts[0]), fact2: (quiz[i].facts[1]), createdAt: timestamp)
        QuizModel.addQuiz(quiz: favoriteQuiz)
        showAlert(title: "Succesfully Favorited Book", message: "")
    
        
        
        dismiss(animated: true, completion: nil)
    }
    
}

