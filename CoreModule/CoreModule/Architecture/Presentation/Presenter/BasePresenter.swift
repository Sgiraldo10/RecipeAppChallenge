//
//  BasePresenter.swift
//  
//
//  Created by Sergio Giraldo on 31/10/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import Combine
import UIKit

open class BasePresenter<ViewControllerType>: BasePresenterType {
    private unowned var viewController: ViewControllerBindable!

    public var subscriberCancellable = Set<AnyCancellable>()

    public var view: ViewControllerType {
        viewController as! ViewControllerType
    }

    public func bind<T>(view: T) where T: ViewControllerBindable {
        guard view is ViewControllerType else {
            fatalError("Object `\(ViewControllerType.self)` passed from: \(self) isn't equal to: \(view)")
        }

        self.viewController = view
    }

    public init() {}

    // MARK: - These methods could be overridden as needed.
    open func viewDidLoad() {}

    open func viewWillAppear() {}

    open func viewDidAppear() {}

    open func viewWillDisappear() {}

    open func viewDidDisappear() {}
}
