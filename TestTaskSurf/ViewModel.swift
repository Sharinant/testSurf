//
//  ViewModel.swift
//  TestTaskSurf
//
//  Created by Антон Шарин on 14.02.2023.
//

import Foundation


class HomeViewModel {
    let names = ["iOS","Android","Flutter","PM","QA","Design"]
    
    
    func giveName(for index:Int)-> String {
        return names[index]
    }
    
    
}
