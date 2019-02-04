//
//  ViewController.swift
//  Quizzes
//
//  Created by Alex Paul on 1/31/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    let quizView = QuizView()
    var quiz = [FavoriteQuiz](){
        didSet{
            DispatchQueue.main.async {
                self.quizView.colloectionView.reloadData()
            }
        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(quizView)
    quizView.colloectionView.register(QuizViewCell.self, forCellWithReuseIdentifier: "QuizCell")
    quizView.colloectionView.dataSource = self
    quizView.colloectionView.delegate = self
    quiz = QuizModel.getQuiz()
  }
    override func viewWillAppear(_ animated: Bool) {
        quiz = QuizModel.getQuiz()
    }


}
extension QuizViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quiz.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as? QuizViewCell else { return UICollectionViewCell() }
        let quizToSet = quiz[indexPath.row]
        
        cell.label.text = quizToSet.quizTitle
        cell.button.layer.setValue(indexPath.row, forKey: "index")
        cell.button.addTarget(self, action: #selector(deleteQuiz), for: .touchUpInside)
        return cell
}
    @objc private func deleteQuiz(sender: UIButton){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alert in
            let i : Int = (sender.layer.value(forKey: "index")) as! Int
           QuizModel.delete(atIndex: i)
            self.quiz = QuizModel.getQuiz()
            print(QuizModel.getQuiz())
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
extension QuizViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thisQuiz = quiz[indexPath.row]
        
        
        let detailVC = DetailViewController()
        detailVC.theQuiz = thisQuiz
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

