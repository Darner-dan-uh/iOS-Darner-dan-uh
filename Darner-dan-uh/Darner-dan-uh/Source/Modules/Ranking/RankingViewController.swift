//
//  RankingVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/08.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class RankingViewController: UIViewController {
    
    @IBOutlet weak var rankingBtn: UIButton!
    @IBOutlet weak var stackBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var myRankingLbl: UILabel!
    @IBOutlet weak var myRankingView: UIView!
    @IBOutlet weak var myRanknumLbl: UILabel!
    @IBOutlet weak var myProfileImage: UIImageView!
    @IBOutlet weak var myNickName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = RankingViewModel()
    private let loadData = BehaviorRelay<Void>(value: ())

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    
//    func bindViewModel() {
//        let input = RankingViewModel.Input(loadData: loadData.asSignal(onErrorJustReturn: ()))
//        let output = viewModel.transform(input)
//        
//        output.loadApplyList.bind(to: tableView.rx.items) { tableView, index, element -> UITableViewCell in
//            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "RankingCell") as? RankingCell else { return RankingCell() }
//            cell.RankingData = element
//            return cell
//        }.disposed(by: disposeBag)
//    }
    
    
    
    private func registerCell() {
        tableView.rowHeight = 75
    }
}

extension RankingViewController {
    private func stackView() {
        stackBtn.rx.tap
            .take(1)
            .map {
                self.navigationController?.popViewController(animated: true)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}

