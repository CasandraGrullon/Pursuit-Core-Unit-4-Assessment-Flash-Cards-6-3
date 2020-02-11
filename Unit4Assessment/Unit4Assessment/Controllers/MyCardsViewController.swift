//
//  MyCardsViewController.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class MyCardsViewController: UIViewController {
    
    private var mycardsView = MyCardsView()
    public var dataPersistence: DataPersistence<Cards>!
    
    private var myCards = [Cards]() {
        didSet {
            mycardsView.collectionView.reloadData()
            if myCards.isEmpty {
                mycardsView.collectionView.backgroundView = EmptyView.init(title: "No Flash Cards", message: "Create your own flashcards or search for preset cards in the other tabs")
            } else {
                mycardsView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = mycardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadMyCards()
        mycardsView.collectionView.delegate = self
        mycardsView.collectionView.dataSource = self
        mycardsView.collectionView.register(MyCardsCell.self, forCellWithReuseIdentifier: "myCardsCell")
    }
    
    func loadMyCards() {
        do {
            myCards = try dataPersistence.loadItems()
        } catch {
            print("could not load cards \(error)")
        }
    }
    
}

extension MyCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
extension MyCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mycardsView.collectionView.dequeueReusableCell(withReuseIdentifier: "myCardsCell", for: indexPath) as? MyCardsCell else {
            fatalError("could not cast to cell")
        }
        let mycard = myCards[indexPath.row]
        cell.configureCell(for: mycard)
        cell.backgroundColor = .white
        return cell
    }
    
    
}
extension MyCardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("did save item")
        loadMyCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("did delete item")
        loadMyCards()
    }
    
    
}
