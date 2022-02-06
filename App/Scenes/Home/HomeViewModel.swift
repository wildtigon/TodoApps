//
//  HomeViewModel.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

final class HomeViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        Output(
            navigateToCallList: input.onCallButtonClicked,
            navigateToBuyList: input.onBuyButtonClicked,
            navigateToSellList: input.onSellButtonClicked
        )
    }
    
    struct Input {
        let onCallButtonClicked: Observable<Void>
        let onBuyButtonClicked: Observable<Void>
        let onSellButtonClicked: Observable<Void>
    }
    
    struct Output {
        let navigateToCallList: Observable<Void>
        let navigateToBuyList: Observable<Void>
        let navigateToSellList: Observable<Void>
    }
}
