//
//  UIViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/28.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, style: UIAlertController.Style, firstAction: UIAlertAction, secAction: UIAlertAction? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .customGray
        alert.view.tintColor = .customPink
        alert.addAction(firstAction)
        if let sec = secAction {
            alert.addAction(sec)
        }
        present(alert, animated: true, completion: nil)
    }
    
}
