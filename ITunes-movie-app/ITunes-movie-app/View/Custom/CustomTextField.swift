//
//  CustomTextField.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 24.10.2023.
//

import UIKit

class CustomTextField: UITextField {
    // Corner radius value for the text field
    @IBInspectable var cornerRadius: CGFloat = 15.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    // Padding for the text within the text field
    @IBInspectable var textPadding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    // Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    private func setupTextField() {
        // Add a border and set other properties
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = UIColor.white
        clipsToBounds = true
        layer.masksToBounds = true

        // Set the corner radius
        layer.cornerRadius = cornerRadius
    }

    // Placeholder text position and padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    // Editable text position and padding
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}



