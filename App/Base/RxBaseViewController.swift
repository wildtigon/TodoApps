//
//  RxBaseViewController.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import RxSwift

class RxBaseViewController<VM: ViewModelTransformable>: BaseViewController<VM> {
    let disposeBag = DisposeBag()
}
