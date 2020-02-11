//
//  SearchCardsViewController.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchCardsViewController: UIViewController {

    private let searchView = SearchCardsView()
    
    public var dataPersistence: DataPersistence<Cards>!
    
    override func loadView() {
        view = searchView
    }
    
    public var presetCards = [Cards]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getCards()
        getLocalCards()
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
    }
    
    private func getCards() {
        CardsAPIClient.getCards { [weak self] (result) in
            switch result {
            case .failure(let appError):
                //TODO: Add showAlert
                print("error getting data \(appError)")
            case .success(let cards):
                self?.presetCards = cards
            }
        }
    }
    private func getLocalCards() {
        do {
            presetCards = try FlashCardService.getlocalCards()
        } catch {
            print("could not get data")
        }
    }
}
extension SearchCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width * 0.8
        let itemHeight: CGFloat = maxsize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}
extension SearchCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presetCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not cast to cell")
        }
        let card = presetCards[indexPath.row]
        cell.configureCell(for: card)
        cell.delegate = self
        cell.backgroundColor = .white
        return cell
    }
}
extension SearchCardsViewController: AddCardDelegate {
    func didAddCard(_ cell: SearchCell, card: Cards) {
        do {
            try dataPersistence.createItem(card)
            showAlert(title: "New Card Saved!", message: "this flashcard is now in your cards collection")
        } catch {
            print("could not save \(error)")
            showAlert(title: "Oops...", message: "unable to save \(error)")
        }
    }
    
//    func didCreateCard(card: Cards) {
//        do {
//            try dataPersistence.createItem(card)
//            showAlert(title: "New Card Saved!", message: "this flashcard is now in your cards collection")
//        } catch {
//            print("could not save \(error)")
//            showAlert(title: "Oops...", message: "unable to save \(error)")
//        }
//    }
}
