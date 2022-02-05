//
//  BuyListViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import RxSwift
import Domain

final class BuyListViewController: RxBaseViewController<BuyListViewModel> {
    private let CELL_HEIGHT: CGFloat = 120
    private var productList = [ProductItem]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(nib: ProductItemCell.self)
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
        title = "Buy List"
        view.addFullSubView(tableView)
    }
    
    private func bindingUI() {
        let viewLoaded = PublishSubject<Void>()
        let input = Input(viewLoaded: viewLoaded)
        let output = viewModel.transform(input: input)
        
        output
            .buyList
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: {
                $0.productList = $1
                $0.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.loadingIndicator.drive(rx.isLoading).disposed(by: disposeBag)
        output.errorTracker.drive(rx.error).disposed(by: disposeBag)
        
        viewLoaded.onNext(())
    }
}

extension BuyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CELL_HEIGHT
    }
}

extension BuyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(nib: ProductItemCell.self, at: indexPath) else {
            return UITableViewCell()
        }
        let productItem = productList[indexPath.row]
        
        cell.name = productItem.name
        cell.price = productItem.price
        cell.quantity = productItem.quantity
        
        return cell
    }
}
