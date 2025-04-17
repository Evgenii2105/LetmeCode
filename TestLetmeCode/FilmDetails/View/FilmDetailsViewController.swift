//
//  FilmDetailsViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 17.04.2025.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    var presenter: FilmDetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
}

extension FilmDetailsViewController: FilmDetailsView {
    
}
