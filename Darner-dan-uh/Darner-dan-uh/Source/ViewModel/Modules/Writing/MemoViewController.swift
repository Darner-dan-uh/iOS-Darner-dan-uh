//
//  MemoViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/26.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MemoViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var memoLbl: UILabel!
    @IBOutlet weak var writeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MemoViewModel()
    private let loadData = BehaviorSubject<Void>(value: ())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //User Default 그거가 안먹음
        memoView.layer.borderColor = UIColor.gray.cgColor
        memoView.layer.borderWidth = 1.5
        memoView.layer.cornerRadius = 20
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "LogoImage")
        imageView.image = image
        navigationItem.titleView = imageView

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.tintColor = .customPink
    }
    
    func bindViewModel() {
        let input = MemoViewModel.Input(loadData: loadData.asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        
        output.loadApplyList.bind(to: tableView.rx.items) { tableView, index, element -> UITableViewCell in
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MemoCell") as? MemoCell else { return MemoCell() }
            cell.MemoData = element
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func registerCell() {
        tableView.rowHeight = 60
    }
    

   

}
