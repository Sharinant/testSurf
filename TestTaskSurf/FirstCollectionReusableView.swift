//
//  FirstCollectionReusableView.swift
//  TestTaskSurf
//
//  Created by Антон Шарин on 14.02.2023.
//

import UIKit

class FirstCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "first"
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Стажировка в Surf"
        return label
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = .gray
        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        return label
    }()
    
    func setup() {
        addSubview(titleLabel)
        addSubview(label)
        titleLabel.frame = CGRect(x: 5, y: 0, width: self.frame.width, height: 50)
        label.frame = CGRect(x: 5, y: 51, width: self.frame.width, height: 100)
    }
}
