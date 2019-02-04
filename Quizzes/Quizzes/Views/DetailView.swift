//
//  DetailView.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/3/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var colloectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.itemSize = CGSize.init(width: 300, height: 300)
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: UIScreen.main.bounds)
        
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        backgroundColor = .white
        setUpThisView()
    }
}

extension DetailView {
    
    private func setUpThisView(){
        setUpThisCollectionView()
        
    }
    
    func setUpThisCollectionView(){
        addSubview(colloectionView)
        colloectionView.translatesAutoresizingMaskIntoConstraints = false
        colloectionView.topAnchor.constraint(equalTo:safeAreaLayoutGuide.topAnchor).isActive = true
        colloectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        colloectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1).isActive = true
    }
    
}
