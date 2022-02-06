//
//  GenericTableViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import UIKit
import RxSwift
import Domain

class GenericTableViewController<VM: ViewModelTransformable, Item>: RxBaseViewController<VM>, UITableViewDataSource, UITableViewDelegate {
    var items = [Item]()
    var onSelect: ((Item) -> Void)?

    private let cellDescriptor: (Item) -> CellDescriptor
    private var reuseIdentifiers: Set<String> = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(viewModel: VM, analyticsService: AnalyticsService? = nil,
         nibName: String? = nil, cellDescriptor: @escaping (Item) -> CellDescriptor) {
        self.cellDescriptor = cellDescriptor
        super.init(viewModel: viewModel, analyticsService: analyticsService, nibName: nibName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWidgets()
        bindingUI()
    }
    
    func bindingUI() {
        
    }
    
    private func initWidgets() {
        view.addFullSubView(tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.row]
        return cellDescriptor(item).cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)
        let identifier = descriptor.cellClass.reuseIdentifier
        
        if !reuseIdentifiers.contains(identifier) {
            tableView.register(nib: descriptor.cellClass)
            reuseIdentifiers.insert(identifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }
}
