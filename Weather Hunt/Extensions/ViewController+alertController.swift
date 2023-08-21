//
//  ViewController+alertController.swift
//  Weather Hunt
//
//  Created by mac on 20.08.2023.
//

import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {

        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }

        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        [search, cancel].forEach {ac.addAction($0)}
        present(ac, animated: true, completion: nil)
    }
}
