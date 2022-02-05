//
//  CallListViewModel.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift
import Domain

final class CallListViewModel: BaseViewModel {
    
    private let useCase: CallListUseCase
    private let loadingIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    init(useCase: CallListUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let contactList = input
            .viewLoaded
            .withUnretained(self)
            .flatMapLatest({ (vm, _) in
                vm.useCase.fetchContactList
                    .trackActivity(vm.loadingIndicator)
                    .trackError(vm.errorTracker)
            })
            
        return Output(
            contactList: contactList,
            loadingIndicator: loadingIndicator,
            errorTracker: errorTracker
        )
    }
    
    struct Input {
        let viewLoaded: Observable<Void>
    }
    
    struct Output {
        let contactList: Observable<[Contact]>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
}
