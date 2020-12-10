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
    lazy var resultWord = BehaviorSubject<[TestRusultModel]>(value: list)
    var list: [TestRusultModel] = []
    private let disposeBag = DisposeBag()
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

        let words: Observable<WordModel> = DarnerAPIClient.shared.networkingResult(from:.wordTest)
        words.map { $0.content! }
            .bind(to: collectionView.rx.items(cellIdentifier: TestCollectionViewCell.cellName, cellType: TestCollectionViewCell.self)) { idx, model, cell in
                let word: String
                if idx % 2 == 0 {
                    cell.wordTestLbl?.text = model.korea
                    word = model.english
                } else {
                    cell.wordTestLbl?.text = model.english
                    word = model.korea
                }
                cell.sign = { txt in
                    if txt == "" {
                        self.presentAlert(message: "값이 비었습니다.", title: "정답을 채워주세요.", actionStyle: .destructive, handler: nil)
                        return
                    }
                    self.checkValue(txt, word, cell.wordTestLbl.text!)
                    if idx == self.wordnum - 1 {
                        self.presentAlert(message: "마지막 문제입니다", title: "결과 확인하기", actionStyle: .destructive) { _ in
                            let vc = self.makeVC(storyBoardName: .memo, identifier: .testResultVC) as TestResultViewController
                            vc.arr = self.resultWord
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    self.nextCell()
                }
            }.disposed(by: disposeBag)
    }
}

extension TestViewController {
    func checkValue(_ userAnswer: String, _ answer: String, _ mean: String) {
        if userAnswer == answer {
            self.list.append(TestRusultModel(word: mean, correct: true))
            resultWord.onNext(self.list)
        } else {
            self.list.append(TestRusultModel(word: mean, correct: false))
            resultWord.onNext(self.list)
        }
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
