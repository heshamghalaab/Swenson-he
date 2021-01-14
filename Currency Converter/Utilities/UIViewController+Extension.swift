//
//  UIViewController+Extension.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

extension UIViewController{
    func alert(title: String, message: String, handler: @escaping () -> Void){
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in handler() }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
