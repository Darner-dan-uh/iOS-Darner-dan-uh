//
//  MemoViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/12/07.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MemoViewController: UIViewController, UITableViewDataSource {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var memoLbl: UILabel!
    @IBOutlet weak var writeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerCell()
        bindAction()
        navigationImage()
        navigationClear()
        
        memoView.layer.borderColor = UIColor.black.cgColor
        memoView.layer.borderWidth = 1.5
        memoView.layer.cornerRadius = 20
        

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemoModel.dummyDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        let target = MemoModel.dummyDataList[indexPath.row]
        cell.textLabel?.text = target.content
        
        return cell
    }
    
    func registerCell() {
        tableView.rowHeight = 80
    }
    
    func bindAction() {
        writeBtn.rx.tap
            .subscribe(onNext: { _ in
                self.nextView(identifier: "write")
            }).disposed(by: disposeBag)
    }
    
  

  
}
