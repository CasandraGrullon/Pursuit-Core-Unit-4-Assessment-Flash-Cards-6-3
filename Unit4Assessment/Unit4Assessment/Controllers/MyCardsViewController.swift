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
        mycardsView.collectionView.delegate = self
        mycardsView.collectionView.dataSource = self
        mycardsView.collectionView.register(MyCardsCell.self, forCellWithReuseIdentifier: "myCardsCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadMyCards()
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
        let itemWidth: CGFloat = maxsize.width * 0.8
        let itemHeight: CGFloat = maxsize.height * 0.30
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
        cell.selectedCard = mycard
        cell.delegate = self
        return cell
    }    
    
}
extension MyCardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadMyCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadMyCards()
    }
}

extension MyCardsViewController: CellDetailsDelegate {
    func didPressButton(cell: MyCardsCell, card: Cards) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCard(card: card)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteCard(card: Cards) {
        guard let index = myCards.firstIndex(of: card) else {
            return
        }
        do{
            try dataPersistence.deleteItem(at: index)
            showAlert(title: "Deleted", message: "card was successfully deleted")
        }catch {
            showAlert(title: "Error", message: "card could not be deleted")
        }
    }
}
