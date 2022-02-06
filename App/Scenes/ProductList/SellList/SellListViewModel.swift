//
//  SellListViewModel.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift
import Domain

final class SellListViewModel: BaseViewModel {
    
    private let useCase: SellListUseCase
    private let loadingIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    init(useCase: SellListUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let sellList = input
            .viewLoaded
            .withUnretained(self)
            .flatMapLatest({ (vm, _) in
                vm.useCase.fetchSellListItem
                    .trackActivity(vm.loadingIndicator)
                    .trackError(vm.errorTracker)
            })
            
        return Output(
            sellList: sellList,
            title: input.viewLoaded.map({_ in "Sell List"}),
            loadingIndicator: loadingIndicator,
            errorTracker: errorTracker
        )
    }
    
    struct Input {
        let viewLoaded: Observable<Void>
    }
    
    struct Output {
        let sellList: Observable<[ProductItem]>
        let title: Observable<String>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
}
