//
//  ViewModelTransformable.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

protocol ViewModelTransformable: AnyObject {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
