//
//  HomeViewController.swift
//  AskQueue
//
//  Created by Rafael Galdino on 16/01/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

// MARK: Variables
    var msgLabel: UILabel?
    var inputTextField: UITextField?
    var textToLabel: NSLayoutConstraint?
    var textToTop: NSLayoutConstraint?
    var connectButton: UIButton?
    let textFieldDelegate = TextFieldDelegate()

// MARK: System Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHome()
        setupLabel()
        setupTextField()
        setupButton()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

// MARK: Visual Components Setups
    func setupHome() {
        self.view.backgroundColor = UIColor.AskQueue.black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "AskQueue"
        setupRightButton()
    }

    func setupRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(createQueue))
        self.navigationController?.navigationBar.tintColor = UIColor.AskQueue.lightGreen
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.AskQueue.white]
    }

    func setupLabel() {
        msgLabel = UILabel(frame: .zero)
        guard let label = msgLabel else {
            return
        }
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Insira abaixo \no código de \numa fila"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.AskQueue.white
        label.sizeToFit()

        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
    }

    func setupTextField() {
        inputTextField = UITextField(frame: .zero)
        guard let textField = inputTextField, let label = msgLabel else {
            return
        }
        textField.layer.cornerRadius = self.view.frame.width * 0.05
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.AskQueue.white.cgColor
        textField.layer.borderWidth = 2
        textField.textAlignment = .center
        textField.tag = 1
        textField.delegate = textFieldDelegate

        textField.textColor = UIColor.AskQueue.white

        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing(_:)))

        self.view.addSubview(textField)
        self.view.addGestureRecognizer(tap)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textToLabel = textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        textToTop = textField.topAnchor.constraint(equalTo: self.navigationController?.navigationBar.bottomAnchor
            ?? self.view.topAnchor, constant: 20)
        textToLabel?.isActive = true
        textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
    }

    func setupButton() {
        connectButton = UIButton(frame: .zero)
        guard let button = connectButton, let textField = inputTextField else {
            return
        }
        button.layer.cornerRadius = self.view.frame.width * 0.05
        button.clipsToBounds = true
        button.setTitle("Entrar", for: .normal)
        button.addTarget(self, action: #selector(joinQueue),
                         for: .touchDown)
        button.setTitleColor(UIColor.AskQueue.darkGreen,
                             for: .highlighted)
        button.setTitleColor(UIColor.AskQueue.white,
                             for: .normal)
        button.backgroundColor = UIColor.AskQueue.lightGreen

        self.view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
    }

// MARK: Trigger Action Functions
    @objc func createQueue() {
        print("created Queue")
    }

    @objc func joinQueue() {
        inputTextField?.resignFirstResponder()
        print("joined Queue")
    }

    @objc func keyboardWillShow() {
        UIView.animate(withDuration: 0.5) {
            self.textToLabel?.isActive = false
            self.textToTop?.isActive = true
            self.msgLabel?.isHidden = true
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.5) {
            self.textToTop?.isActive = false
            self.textToLabel?.isActive = true
            self.msgLabel?.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
}
