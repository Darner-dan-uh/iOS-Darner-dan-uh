//
//  UIViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/28.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(message: String, style: UIAlertController.Style? = .alert, title: String, actionStyle: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?, secTitle: String? = nil, secActionStyle: UIAlertAction.Style? = nil, secHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "     ", message: message, preferredStyle: .alert)
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "BinggraeMelona", size: 17)]
        let titleAttrString = NSMutableAttributedString(string: message, attributes: titleFont)
        alert.setValue(titleAttrString, forKey:"attributedMessage")
        
        alert.addAction(UIAlertAction(title: title, style: actionStyle, handler: handler))
        if let existSecTitle = secTitle { alert.addAction(UIAlertAction(title: existSecTitle, style: secActionStyle!, handler: secHandler)) }
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .customGray
        alert.view.tintColor = .black
        present(alert, animated: true, completion: nil)
    }
    
    func makeVC<T>(storyBoardName: String? = nil, identifier: ViewControllerName) -> T where T: UIViewController {
        //        let storyBoard = UIStoryboard(name: storyBoardName!, bundle: nil)
        let vc = storyboard?.instantiateViewController(identifier: identifier.rawValue) as! T
        return vc
    }
}
