//
//  CallListViewModelTest.swift
//  AppTests
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import XCTest
import RxTest
import RxSwift
import Domain
@testable import App

class CallListViewModelTest: XCTestCase {
    private var vm: CallListViewModel?
    private var disposeBag: DisposeBag!
    private var input:  CallListViewModel.Input!
    private var output: CallListViewModel.Output!
    private var scheduler: TestScheduler!
    private let viewLoadedTrigger = PublishSubject<Void>()
    
    override func setUp() {
        vm = container.resolve(CallListViewModel.self)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        
        input = CallListViewModel.Input(viewLoaded: viewLoadedTrigger)
        output = vm?.transform(input: input)
    }
    
    override func tearDown() {
        vm = nil
        disposeBag = nil
        input = nil
        output = nil
        scheduler = nil
    }
    
    func test_vm_can_be_initiated() {
        XCTAssertNotNil(vm)
    }
    
    func test_vm_title() {
        let titleOutput = scheduler.createObserver(String.self)
        output.title.bind(to: titleOutput).disposed(by: disposeBag)

        scheduler
            .createHotObservable([
                .next(100, ())
            ])
            .bind(to: viewLoadedTrigger)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(titleOutput.events, [
            .next(100, "Call List")
        ])
    }
    
    func test_vm_fetch_count() {
        let contactOutput = scheduler.createObserver(Int.self)
        output.contactList.map(\.count)
            .bind(to: contactOutput)
            .disposed(by: disposeBag)
       
        scheduler
            .createHotObservable([
                .next(100, ())
            ])
            .bind(to: viewLoadedTrigger)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(contactOutput.events, [
            .next(100, 3)
        ])
    }
    
    func test_vm_number_request() {
        let contactOutput = scheduler.createObserver([Contact].self)
        output.contactList.bind(to: contactOutput).disposed(by: disposeBag)
       
        scheduler
            .createHotObservable([
                .next(100, ())
            ])
            .bind(to: viewLoadedTrigger)
            .disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(contactOutput.events.count, 1)
    }
}
