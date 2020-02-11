//
//  CreateCardsView.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardsView: UIView {

    public lazy var buttonStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    public lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        //TODO: add target
        return button
    }()
    public lazy var saveButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create", for: .normal)
        //TODO: add target
        return button
    }()
    public lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter subject"
        textField.backgroundColor = .white
        return textField
    }()
    public lazy var factOneText: UITextView = {
       let textView = UITextView()
        textView.text = "enter description 1"
        textView.textColor = .systemGray
        textView.isSelectable = true
        textView.isEditable = true
        return textView
    }()
    public lazy var factTwoText: UITextView = {
       let textView = UITextView()
        textView.text = "enter description 2"
        textView.textColor = .systemGray
        textView.isEditable = true
        textView.isSelectable = true
        return textView
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        stackViewConstraints()
        textFieldConstraints()
        textView1Constraints()
        textView2Constraints()
    }
    private func stackViewConstraints() {
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonStack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    private func textFieldConstraints() {
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func textView1Constraints() {
        addSubview(factOneText)
        factOneText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factOneText.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            factOneText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            factOneText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            factOneText.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func textView2Constraints() {
        addSubview(factTwoText)
        factTwoText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factTwoText.topAnchor.constraint(equalTo: factOneText.bottomAnchor, constant: 10),
            factTwoText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            factTwoText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            factTwoText.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
