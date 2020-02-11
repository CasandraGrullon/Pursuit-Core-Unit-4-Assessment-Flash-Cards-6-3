//
//  CreateCardsViewController.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardsViewController: UIViewController {

    private let createView = CreateCardsView()
    public var dataPersistence: DataPersistence<Cards>!
    private lazy var tapGesture: UITapGestureRecognizer = {
       let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        gesture.numberOfTapsRequired = 1
        return gesture
    }()
    override func loadView() {
        view = createView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createView.addGestureRecognizer(tapGesture)
        createView.titleTextField.delegate = self
        createView.factOneText.delegate = self
        createView.factTwoText.delegate = self
        createView.delegate = self
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        createView.titleTextField.resignFirstResponder()
        createView.factTwoText.resignFirstResponder()
        createView.factOneText.resignFirstResponder()
    }

}

extension CreateCardsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension CreateCardsViewController: UITextViewDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
extension CreateCardsViewController: SaveCreateCardsDelegate {
    func didCreateCard(card: Cards) {
        do {
            try dataPersistence.createItem(card)
            showAlert(title: "New Card Saved!", message: "your new flashcard is now in your cards collection")
        } catch {
            showAlert(title: "Oops...", message: "unable to save \(error)")
        }
    }
    
    
}
