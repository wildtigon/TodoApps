//
//  Constraint.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint
func equal<Axis, L>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { child, parent in
        child[keyPath: from].constraint(equalTo: parent[keyPath: to])
    }
}

func equal<Axis, L>(_ keyPath: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { child, parent in
        child[keyPath: keyPath].constraint(equalTo: parent[keyPath: keyPath])
    }
}

func equal<Axis, L>(_ keyPath: KeyPath<UIView, L>, _ constant: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { child, parent in
        child[keyPath: keyPath].constraint(equalTo: parent[keyPath: keyPath], constant: constant)
    }
}

func equal<L>(_ keyPath: KeyPath<UIView, L>, _ constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { child, parent in
        child[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}

extension UIView {
    func addSubView(_ view: UIView, _ constraints: [Constraint]) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.map({
            $0(view, self)
        }))
    }
    
    func addFullSubView(_ view: UIView) {
        addSubView(view, [
            equal(\.leadingAnchor), equal(\.topAnchor),
            equal(\.trailingAnchor), equal(\.bottomAnchor),
        ])
    }
}

