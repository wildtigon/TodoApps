//
//  HomeViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: RxBaseViewController<HomeViewModel> {
    
    @IBOutlet weak private var btnCallList: UIButton!
    @IBOutlet weak private var btnBuyList: UIButton!
    @IBOutlet weak private var btnSellList: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
    }
    
    private func bindingUI() {
        let input = Input(
            onCallButtonClicked: btnCallList.rx.tap.asObservable(),
            onBuyButtonClicked: btnBuyList.rx.tap.asObservable(),
            onSellButtonClicked: btnSellList.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.navigateToSellList
            .asDriverOnErrorJustComplete()
            .drive { _ in
                ScreenCordinator.showSellListScreen()
            }
            .disposed(by: disposeBag)
        
        output.navigateToCallList
            .asDriverOnErrorJustComplete()
            .drive { _ in
                ScreenCordinator.showCallListScreen()
            }
            .disposed(by: disposeBag)
        
        output.navigateToBuyList
            .asDriverOnErrorJustComplete()
            .drive { _ in
                ScreenCordinator.showBuyListScreen()
            }
            .disposed(by: disposeBag)
    }
}
