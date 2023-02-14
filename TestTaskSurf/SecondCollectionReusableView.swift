//
//  SecondCollectionReusableView.swift
//  TestTaskSurf
//
//  Created by Антон Шарин on 14.02.2023.
//

import UIKit

class SecondCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "second"

    
    let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        return label
    }()
    
    func setup() {
        addSubview(label)
        label.frame = self.bounds
    }
}
