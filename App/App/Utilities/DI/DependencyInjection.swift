//
//  DependencyInjection.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Domain
import Data
import Swinject

let container = Container()
final class DependencyInjection {
    
    static func config(with analyticsService: AnalyticsService?) {
        configProduction()
        genericConfigs(with: analyticsService)
    }
    
    static private func genericConfigs(with analyticsService: AnalyticsService?) {
        // HOME
        container.register(HomeViewModel.self) { _ in  .init() }
        container.register(HomeViewController.self) { r in
            let vm = r.resolve(HomeViewModel.self)!
            return .init(viewModel: vm, analyticsService: analyticsService, nibName: "HomeViewController")
        }
        
        // Call List
        container.register(CallListUseCase.self) { r in
            let repo = r.resolve(CallListRepository.self)!
            return CallListUseCaseImpl(with: repo)
        }
        container.register(CallListViewModel.self) { r in
            let useCase = r.resolve(CallListUseCase.self)!
            return CallListViewModel(useCase: useCase)
        }
        container.register(CallListViewController.self) { r in
            let viewModel = r.resolve(CallListViewModel.self)!
            return CallListViewController(viewModel: viewModel)
        }
        
        // Buy List
        container.register(BuyListUseCase.self) { r in
            let repo = r.resolve(BuyListRepository.self)!
            return BuyListUseCaseImpl(with: repo)
        }
        container.register(BuyListViewModel.self) { r in
            let useCase = r.resolve(BuyListUseCase.self)!
            return BuyListViewModel(useCase: useCase)
        }
        container.register(BuyListViewController.self) { r in
            let viewModel = r.resolve(BuyListViewModel.self)!
            return BuyListViewController(viewModel: viewModel)
        }
        
        // Sell List
        container.register(SellListUseCase.self) { r in
            let repo = r.resolve(SellListRepository.self)!
            return SellListUseCaseImpl(with: repo)
        }
        container.register(SellListViewModel.self) { r in
            let useCase = r.resolve(SellListUseCase.self)!
            return SellListViewModel(useCase: useCase)
        }
        container.register(SellListViewController.self) { r in
            let viewModel = r.resolve(SellListViewModel.self)!
            return SellListViewController(viewModel: viewModel)
        }
    }
    
    static private func configProduction() {
        container.register(CallListRepository.self) { _ in NetworkCallListRepository() }
        container.register(BuyListRepository.self) { _ in NetworkBuyListRepository() }
//        container.register(SellListRepository.self) { _ in CoreDataSellListRepository() }
        container.register(SellListRepository.self) { _ in DummySellListRepository() }
    }
    
    static private func configTest() {
        container.register(CallListRepository.self) { _ in DummyCallListRepository() }
        container.register(BuyListRepository.self) { _ in DummyBuyListRepository() }
        container.register(SellListRepository.self) { _ in DummySellListRepository() }
    }
}
