//
//  BuyListViewModel.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift
import Domain

final class BuyListViewModel: BaseViewModel {
    
    private let useCase: BuyListUseCase
    private let loadingIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    init(useCase: BuyListUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let buyList = input
            .viewLoaded
            .withUnretained(self)
            .flatMapLatest({ (vm, _) in
                vm.useCase.fetchBuyListItem
                    .trackActivity(vm.loadingIndicator)
                    .trackError(vm.errorTracker)
            })
            
        return Output(
            buyList: buyList,
            loadingIndicator: loadingIndicator,
            errorTracker: errorTracker
        )
    }
    
    struct Input {
        let viewLoaded: Observable<Void>
    }
    
    struct Output {
        let buyList: Observable<[ProductItem]>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
}
