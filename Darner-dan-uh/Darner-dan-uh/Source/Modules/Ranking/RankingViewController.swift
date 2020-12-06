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
    @IBOutlet weak var myNickName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = RankingViewModel()
    private let loadData = BehaviorRelay<Void>(value: ())

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        registerCell()
        navigationImage()
        navigationClear()
        rank()
        myRank()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // self.navigationController?.isNavigationBarHidden = true
    }
    
    func myRank() {
        let rank: Observable<a> = DarnerAPIClient.shared.networkingResult(from: .myrank("smKim"))
        rank.asObservable().subscribe(onNext: { model in
            self.myRanknumLbl.text = String(model.rank ?? 1)
        }).disposed(by: disposeBag)
    }
    
    func rank() {

        let rank: Observable<Ranking> = DarnerAPIClient.shared.networkingResult(from: .rank(3))
        rank.map { $0.ranking }.bind(to: tableView.rx.items(cellIdentifier: "rankingCell", cellType: RankingCell.self)) { idx, model, cell in
            cell.nickNameLbl?.text = model.name
            cell.RankingLbl?.text = String(model.rank ?? 1)
        }.disposed(by: disposeBag)
    }
    
    private func registerCell() {
        tableView.rowHeight = 80
    }
}
struct a: Codable {
    let rank: Int?
    let message: String?
}


extension UIViewController {
    func navigationClear() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    
    func navigationImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 35))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "LogoImage")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }

}

