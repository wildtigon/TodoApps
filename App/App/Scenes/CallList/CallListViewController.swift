//
//  CallListViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import RxSwift
import Domain

final class CallListViewController: RxBaseViewController<CallListViewModel> {
    private let CELL_HEIGHT: CGFloat = 80
    private var contactList = [Contact]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(nib: ContactCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initWidgets()
        bindingUI()
    }
    
    private func initWidgets() {
        title = "Call List"
        view.addFullSubView(tableView)
    }
    
    private func bindingUI() {
        let viewLoaded = PublishSubject<Void>()
        let input = Input(viewLoaded: viewLoaded)
        let output = viewModel.transform(input: input)
        
        output
            .contactList
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: {
                $0.contactList = $1
                $0.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.loadingIndicator.drive(rx.isLoading).disposed(by: disposeBag)
        output.errorTracker.drive(rx.error).disposed(by: disposeBag)
        
        viewLoaded.onNext(())
    }
}

extension CallListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CELL_HEIGHT
    }
}

extension CallListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(nib: ContactCell.self, at: indexPath) else {
            return UITableViewCell()
        }
        
        let contact = contactList[indexPath.row]
        
        cell.titleName = contact.name
        cell.titlePhone = contact.number
        
        return cell
    }
}
