//
//  WritingVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/09/03.
//  Copyright © 2020 이현욱. All rights reserved.
//
import UIKit

import RxSwift
import RxCocoa

class WritingViewController: UIViewController {
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var writingTxtView: UITextView!
    
    private let disposeBag = DisposeBag()
    var dummyData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memo = UserDefaults.standard.object(forKey: "no") as? Int
        
        if(memo == -1) {
            dummyData = (UserDefaults.standard.object(forKey: "data") as? [String])!
            writingTxtView.text = "...";
            
        }
        
        writingTxtView.layer.borderWidth = 2
        writingTxtView.layer.borderColor = UIColor.gray.cgColor
        writingTxtView.layer.cornerRadius = 15
        
        save(saveBtn)
        bindAction()
        navigationImage()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = false
    }
    
    func save(_ button: UIBarButtonItem) {
        let memo = UserDefaults.standard.object(forKey: "no") as? Int
        
        if(memo == -1) {
            dummyData.insert(writingTxtView.text, at: 0)
            UserDefaults.standard.set(dummyData, forKey: "data")
       }
 //           else {
//            dummyData.remove(at: memo?)
//            dummyData.insert(writingTxtView.text, at: memo?)
//
//            UserDefaults.standard.set(dummyData, forKey: "data")
//        }
        
        print("save")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func bindAction() {
        saveBtn.rx.tap
            .subscribe(onNext: { _ in
                self.backView(identifire: "memo")
            }).disposed(by: disposeBag)
    }
}

extension UIViewController {
    func backView(identifire: String) {
        navigationController!.popViewController(animated: true)
    }
}


