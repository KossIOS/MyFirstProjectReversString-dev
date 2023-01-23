//
//  ViewController.swift
//  MyFirstProjectReversString
//
//  Created by Konstantyn Koroban on 27/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    enum Condition {
        case defaultReverse
        case customReverse
    }
    
    @IBOutlet weak var mainTextFieldInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resultTextViewOutput: UITextView!
    @IBOutlet weak var ignoreInputStringTextFld: UITextField!
    @IBOutlet weak var segmentControlSwitchCondition: UISegmentedControl!
    @IBOutlet weak var textInfoLabel: UILabel!
    @IBOutlet weak var buttonImitationLabel: UILabel!
    
    private let model = ReversePhraseService()
    private var reverseState: Condition = .defaultReverse {
        didSet {
            if reverseState == .defaultReverse {
                ignoreInputStringTextFld.isHidden = true
                textInfoLabel.isHidden = false
                defaultReverse()
                
            } else {
                textInfoLabel.isHidden = true
                ignoreInputStringTextFld.isHidden = false
                customReverse()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextFieldInput.delegate = self
        ignoreInputStringTextFld.isHidden = true
        changedAccesabillityLabel()
        defaultReverse()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func switchConditions(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            reverseState = .defaultReverse
        } else {
            reverseState = .customReverse
        }
    }
    
    private func defaultReverse() {
        setDefaultReverseLabel()
        mainTextFieldInput.setOnTextChangeListener { [weak self] in
            self?.setDefaultReverseLabel()
        }
    }
    
    private func customReverse() {
        setCustomReverseLabel()
        self.ignoreInputStringTextFld.setOnTextChangeListener { [weak self] in
            self?.setCustomReverseLabel()
        }
    }
    
    private func setDefaultReverseLabel() {
        resultTextViewOutput.text = model.reverse(phrase: mainTextFieldInput.text ?? "")
    }
    
    private func setCustomReverseLabel() {
        resultTextViewOutput.text = model.reverse(
            phrase: mainTextFieldInput.text ?? "",
            ignoredCharacters: ignoreInputStringTextFld.text ?? ""
        )
    }
    
    private func changedAccesabillityLabel() {
        mainTextFieldInput.accessibilityLabel = "reverseTextField"
        resultTextViewOutput.accessibilityLabel  = "resultTextView"
        ignoreInputStringTextFld.accessibilityLabel = "ignoreCharactersTextField"
        textInfoLabel.accessibilityLabel = "allCharactersLabel"
        segmentControlSwitchCondition.accessibilityLabel = "switchCondition"
    }
}
