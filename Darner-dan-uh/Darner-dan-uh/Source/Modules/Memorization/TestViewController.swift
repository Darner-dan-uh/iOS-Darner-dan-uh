//
//  TestViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/01.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class TestViewController: UIViewController {
    static var resultWord: PublishSubject<TestRusultModel>! = nil
    var list: [TestRusultModel]?
    private let disposeBag = DisposeBag()
    var wordid: Int = 0 // 없애야됨
    var wordnum: Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var popVCBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindAction()
        // Do any additional setup after loading the view.
    }
    
}

extension TestViewController {
    private func bindAction() {
        popVCBtn.rx.tap
            .map {
                self.presentAlert(message: "시험을 포기하시겠어요?", style: .alert, title: "포기하겠습니다", actionStyle: .destructive, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }, secTitle: "계속 할게요", secActionStyle: .default, secHandler: nil)
            }.subscribe().disposed(by: disposeBag)
    }
    
    private func bindUI() {
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        //        let words: Observable<WordModel> = DarnerAPIClient.shared.networkingResult(from:.wordTest)
        //        words.map { $0.content! }
        //            .bind(to: collectionView.rx.items(cellIdentifier: TestCollectionViewCell.cellName, cellType: TestCollectionViewCell.self)) { idx, model, cell in
        //                if idx % 2 == 0 {
        //                    cell.wordTestLbl?.text = model.korea
        //                } else {
        //                    cell.wordTestLbl?.text = model.english
        //                }
        //            }.disposed(by: disposeBag)
        
        let words: Observable<WordModel> = DarnerAPIClient.shared.networkingResult(from: .wordGenre(word_id: String(self.wordid), number: String(self.wordnum)))
        words.map { $0.content! }
            .bind(to: collectionView.rx.items(cellIdentifier: TestCollectionViewCell.cellName, cellType: TestCollectionViewCell.self)) { idx, model, cell in
                if idx % 2 == 0 {
                    cell.wordTestLbl?.text = model.korea
                } else {
                    cell.wordTestLbl?.text = model.english
                }
                cell.sign = { txt in
                    if txt == "" {
                        self.presentAlert(message: "값이 비었습니다.", title: "정답을 채워주세요.", actionStyle: .cancel, handler: nil)
                        return
                    }
                    self.checkValue(txt, cell.wordTestLbl.text!)
                    if idx == self.wordnum - 1 {
                        self.presentAlert(message: "마지막 문제입니다", title: "결과 확인하기", actionStyle: .destructive) { _ in
                            let vc = self.makeVC(storyBoardName: .memo, identifier: .testResultVC) as TestResultViewController
                            print("다음으로 보내기전에 : ",self.list)
                            vc.arr = self.list
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    self.nextCell()
                }
            }.disposed(by: disposeBag)
    }
}

extension TestViewController {
    func checkValue(_ userAnswer: String, _ answer: String) {
        if userAnswer == answer {
            self.list?.append(TestRusultModel(word: answer, correct: true))
        } else {
            self.list?.append(TestRusultModel(word: answer, correct: false))
        }
        print("check후: "list)
    }
    
    func nextCell() {
        let cellSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height);
        let contentOffset = self.collectionView.contentOffset;
        self.collectionView.scrollRectToVisible(CGRect(origin: CGPoint(x: contentOffset.x + cellSize.width, y: contentOffset.y), size: CGSize(width: 414, height: 730)), animated: true)
    }
}

extension TestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 414, height: 730)
    }
}
