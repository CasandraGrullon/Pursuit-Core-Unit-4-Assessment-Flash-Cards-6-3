//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol AddCardDelegate: AnyObject {
    func didAddCard(_ cell: SearchCell, card: Cards)
}

class SearchCell: UICollectionViewCell {
    
    weak var delegate: AddCardDelegate?
    
    private var selectedCard: Cards!
    
    public lazy var cardTitle: UILabel = {
       let label = UILabel()
        label.text = "flash card sample"
        label.numberOfLines = 3
        return label
    }()
    public lazy var addButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc public func addButtonPressed(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        guard let card = selectedCard else {
            return
        }
        delegate?.didAddCard(self, card: card)
        print("button pressed")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        buttonConstraints()
        titleConstraints()
    }

    private func buttonConstraints() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    private func titleConstraints() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTitle.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    public func configureCell(for card: Cards) {
        cardTitle.text = card.quizTitle
    }
}
