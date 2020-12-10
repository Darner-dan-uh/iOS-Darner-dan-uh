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
    @IBOutlet weak var myNameLbl: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func myRank() {
        let rank: Observable<a> = DarnerAPIClient.shared.networkingResult(from: .myrank("smKim"))
        rank.asObservable().subscribe(onNext: { model in
            self.myRanknumLbl.text = String(model.rank ?? 3)
        }).disposed(by: disposeBag)
    }
    
    func myRank() {
           let rank: Observable<a> = DarnerAPIClient.shared.networkingResult(from: .myrank("smKim"))
           rank.asObservable().subscribe(onNext: { model in
               self.myRanknumLbl.text = String(model.rank ?? 2)
           }).disposed(by: disposeBag)
       }
       
    func rank() {

           let rank: Observable<Ranking> = DarnerAPIClient.shared.networkingResult(from: .rank(3))
           rank.map { $0.ranking }.bind(to: tableView.rx.items(cellIdentifier: "rankingCell", cellType: RankingCell.self)) { idx, model, cell in
               cell.nickNameLbl?.text = model.name
            cell.RankingLbl?.text = String(model.rank)
           }.disposed(by: disposeBag)
       }
    
    struct a: Codable {
        let rank: Int?
        let message: String?
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

extension UIViewController {
    func navigationImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 35))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "LogoImage")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }

}

