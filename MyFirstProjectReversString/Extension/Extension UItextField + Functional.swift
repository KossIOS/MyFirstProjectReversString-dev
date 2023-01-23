//
//  Extension UItextField + Functional.swift
//  MyFirstProjectMyFirstProjectReversString
//
//  Created by Konstantyn Koroban on 05/11/2022.
//

import Foundation
import UIKit

extension UITextField {
    func setOnTextChangeListener(onTextChanged :@escaping () -> Void) {
            self.addAction(UIAction { _ in
                onTextChanged()
            }, for: .editingChanged)
        }
}
