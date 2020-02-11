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
    
    override func loadView() {
        view = createView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createView.titleTextField.delegate = self
        createView.factOneText.delegate = self
        createView.factTwoText.delegate = self
        createView.delegate = self
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
extension CreateCardsViewController: CreateCardsDelegate {
    func didCreateCard(card: Cards) {
        do {
            try dataPersistence.createItem(card)
        } catch {
            print("could not save card \(error)")
            //TODO: make this a show alert
        }
    }
    
    
}
