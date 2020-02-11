//
//  MyCardsCell.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class MyCardsCell: UICollectionViewCell {
 
    public lazy var cardTitle: UILabel = {
       let label = UILabel()
        label.text = "flash card sample"
        label.numberOfLines = 3
        return label
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
        titleConstraints()
    }
    private func titleConstraints() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    public func configureCell(for card: Cards) {
        cardTitle.text = card.quizTitle
    }
}
