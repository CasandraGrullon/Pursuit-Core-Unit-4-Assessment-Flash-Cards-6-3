//
//  MyCardsViewController.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class MyCardsViewController: UIViewController {

    private var mycardsView = MyCardsView()
    
    override func loadView() {
        view = mycardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mycardsView.collectionView.delegate = self
        //mycardsView.collectionView.dataSource = self
    }
    


}

//extension MyCardsViewController: UICollectionViewDelegateFlowLayout {
//
//}
//extension MyCardsViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}
