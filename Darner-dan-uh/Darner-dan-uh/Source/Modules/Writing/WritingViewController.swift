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

final class WritingViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var writeLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var writingTxtView: UITextView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = WritingViewModel()
    private let write = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //얘도 User Default 안먹음
     //   writingTxtView.layer.borderColor = UIColor.customGray.cgColor
      //  writingTxtView.layer.borderWidth = 1.5
      //  writingTxtView.layer.cornerRadius = 17.5
        
        bindAction()
    
    }
    
    func bindAction() {
            menuBtn.rx.tap.subscribe(onNext: { _ in
                let menu = UIAlertController(title: nil, message: "Memo", preferredStyle: .actionSheet)
                let fixAction = UIAlertAction(title: "고정", style: .default, handler: {
                    (alert: UIAlertAction) -> Void in
                })
                let saveAction = UIAlertAction(title: "저장", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                   // self.navigationController?.popToViewController( MemoViewController, animated: true)
                    
//                    guard let memo = self.writingTxtView.text, memo.count > 0 else {
//                        return
//                    }
//                    self.dismiss(animated: true, completion: nil)
                })
                
                menu.addAction(fixAction)
                menu.addAction(saveAction)
                
                self.present(menu, animated: true, completion: nil)
            }).disposed(by: disposeBag)
            
            backBtn.rx.tap.subscribe(onNext: { _ in
                //self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = WritingViewModel.Input(write: write.asDriver(onErrorJustReturn: ""))
        let output = viewModel.transform(input)
        
        
    }
    

    
}
