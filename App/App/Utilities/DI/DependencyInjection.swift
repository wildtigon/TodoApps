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
            return HomeViewController(
                viewModel: r.resolve(HomeViewModel.self)!,
                analyticsService: analyticsService,
                nibName: "HomeViewController"
            )
        }
        
        // Call List
        container.register(CallListUseCase.self) { r in
            return CallListUseCaseImpl(
                with: r.resolve(RemoteCallListRepository.self)!
            )
        }
        container.register(CallListViewModel.self) { r in
            return CallListViewModel(
                useCase: r.resolve(CallListUseCase.self)!
            )
        }
        container.register(CallListViewController.self) { r in
            return CallListViewController(
                viewModel: r.resolve(CallListViewModel.self)!,
                analyticsService: analyticsService,
                cellDescriptor: CellDescriptor.contactCell
            )
        }
        
        // Buy List
        container.register(BuyListUseCase.self) { r in
            return BuyListUseCaseImpl(
                with: r.resolve(RemoteProductListRepository.self)!
            )
        }
        container.register(BuyListViewModel.self) { r in
            return BuyListViewModel(
                useCase: r.resolve(BuyListUseCase.self)!
            )
        }
        container.register(BuyListViewController.self) { r in
            return BuyListViewController(
                viewModel: r.resolve(BuyListViewModel.self)!,
                analyticsService: analyticsService,
                cellDescriptor: CellDescriptor.productCell
            )
        }
        
        // Sell List
        container.register(SellListUseCase.self) { r in
            return SellListUseCaseImpl(
                with: r.resolve(LocalProductListRepository.self)!
            )
        }
        container.register(SellListViewModel.self) { r in
            return SellListViewModel(
                useCase: r.resolve(SellListUseCase.self)!
            )
        }
        container.register(SellListViewController.self) { r in
            return SellListViewController(
                viewModel: r.resolve(SellListViewModel.self)!,
                analyticsService: analyticsService,
                cellDescriptor: CellDescriptor.productCell
            )
        }
    }
    
    static private func configProduction() {
        container.register(RemoteCallListRepository.self) { _ in RemoteCallListRepositoryImpl() }
        container.register(RemoteProductListRepository.self) { _ in RemoteProductListRepositoryImpl() }
        container.register(LocalProductListRepository.self) { _ in CoreDataProductListRepositoryImpl() }
    }
    
    static private func configTest() {
        container.register(RemoteCallListRepository.self) { _ in RemoteCallListRepositoryDummy() }
        container.register(RemoteProductListRepository.self) { _ in RemoteProductListRepositoryDummy() }
        container.register(LocalProductListRepository.self) { _ in LocalProductListRepositoryDummy() }
    }
}
