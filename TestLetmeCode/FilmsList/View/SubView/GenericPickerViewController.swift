//
//  GenericPickerViewController.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 19.04.2025.
//

import UIKit

final class GenericPickerViewController: UIViewController {
    
    private let pickerView: UIPickerView
    private let items: [String]
    weak var delegate: CustomPickerDelegate?
    
    init(with title: String? = nil, items: [String]) {
        self.pickerView = UIPickerView()
        self.items = items
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    static func makePickerController(with items: [String]) -> UIViewController {
        let picker = GenericPickerViewController(with: "Select Year", items: items)
        let navigationController = UINavigationController(rootViewController: picker)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        return navigationController
    }
    
    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:bundle:) has not been implemented")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pickerView)
        pickerView.backgroundColor = .lightGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = view.bounds
    }
}

// MARK: - UIPickerViewDelegate Protocol

extension GenericPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let year = Int(items[row]) {
                   delegate?.didSelectYear(year: year)
               }
         dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource Protocol

extension GenericPickerViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: items[row], attributes: [.foregroundColor: UIColor.label])
    }
}
