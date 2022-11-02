//
//  BasePresenterType.swift
//  
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//


import UIKit

public protocol BasePresenterType: Bindable {
    associatedtype ViewControllerType
    
    var view: ViewControllerType { get }
}

public protocol Bindable: LifeCycleNotifiable {
    func bind<T: ViewControllerBindable>(view: T)
}

public protocol LifeCycleNotifiable: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}
