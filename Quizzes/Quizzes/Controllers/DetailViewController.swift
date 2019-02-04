//
//  DetailViewController.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/3/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var theQuiz: FavoriteQuiz!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.colloectionView.dataSource = self
        detailView.colloectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCell")

    }
    

}
extension DetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
      
        cell.label.text = theQuiz.quizTitle
        return cell

    }
    
    
}
