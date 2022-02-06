//
//  CallListViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import RxSwift
import Domain

final class CallListViewController: GenericTableViewController<CallListViewModel, Contact> {
    
    override func bindingUI() {
        let viewLoaded = PublishSubject<Void>()
        let input = Input(viewLoaded: viewLoaded)
        let output = viewModel.transform(input: input)
        
        output
            .contactList
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: {
                $0.items = $1
                $0.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.title
            .asDriverOnErrorJustComplete()
            .drive(rx.title)
            .disposed(by: disposeBag)
        
        output.loadingIndicator.drive(rx.isLoading).disposed(by: disposeBag)
        output.errorTracker.drive(rx.error).disposed(by: disposeBag)
        
        viewLoaded.onNext(())
    }
}
