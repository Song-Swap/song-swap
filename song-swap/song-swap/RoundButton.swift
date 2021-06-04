//
//  RoundButton.swift
//  song-swap
//
//  Created by Simonne Contreras on 6/3/21.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
        self.layer.cornerRadius = cornerRadius
        }
    }
}
