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
        return cell
    }
    
    
}
