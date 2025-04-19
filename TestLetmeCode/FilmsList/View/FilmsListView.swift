//
//  FilmsListView.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 16.04.2025.
//

import Foundation

protocol FilmsListView: AnyObject {
    
}

protocol CustomPickerDelegate: AnyObject {
    func didSelectYear(year: Int)
}
