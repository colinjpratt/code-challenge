//
//  ContainerFactory.swift
//  VendingMachine
//
//  Created by Colin on 5/14/20.
//  Copyright © 2020 Colin. All rights reserved.
//

import UIKit
import Swinject

extension Container {
    static let shared = Container()
    
    func resolve<T>() -> T? {
        return Container.shared.resolve(T.self)
    }
}
