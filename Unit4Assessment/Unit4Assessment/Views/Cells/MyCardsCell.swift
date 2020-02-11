//
//  MyCardsCell.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol CellDetailsDelegate: AnyObject {
    func didPressButton(cell: MyCardsCell, card: Cards)
}

class MyCardsCell: UICollectionViewCell {
 
    weak var delegate: CellDetailsDelegate?
    
    private var selectedCard: Cards!
    
    private var isPressed = false
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
       let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressed(_:)))
        return gesture
    }()
    
    public lazy var cardTitle: UILabel = {
       let label = UILabel()
        label.text = "flash card sample"
        label.numberOfLines = 2
        return label
    }()
    public lazy var answers: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    public lazy var moreButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    
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
        answersConstraints()
        addGestureRecognizer(longPressGesture)
    }
    @objc private func moreButtonPressed(_ sender: UIButton) {
        guard let card = selectedCard else {
            return
        }
        delegate?.didPressButton(cell: self, card: card)
    }
    @objc private func longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isPressed.toggle()
        
        animate()
        
    }
    private func animate() {
        if isPressed {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromRight], animations: {
                self.answers.alpha = 1.0
                self.cardTitle.alpha = 0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
                self.answers.alpha = 0
                self.cardTitle.alpha = 1.0
            }, completion: nil)
        }
    }
    private func buttonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moreButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func titleConstraints() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 10),
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func answersConstraints() {
        addSubview(answers)
        answers.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answers.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            answers.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            answers.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            answers.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    public func configureCell(for card: Cards) {
        cardTitle.text = card.quizTitle
        answers.text = "\(card.facts.first ?? "") \n\(card.facts.last ?? "")"
    }
}
