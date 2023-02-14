//
//  ButtonCollectionViewCell.swift
//  TestTaskSurf
//
//  Created by Антон Шарин on 14.02.2023.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "Identifier"
    
    let button : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        return button
    }()
    
    func setup(with name : String) {
        addSubview(button)
        button.setTitle(name, for: .normal)
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    
    
}
