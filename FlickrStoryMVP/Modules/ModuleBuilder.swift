//
//  ModuleBuilder.swift
//  FlickrStoryMVP
//
//  Created by Владислав Лазарев on 02.03.2020.
//  Copyright © 2020 Владислав Лазарев. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(photo: Photo?) -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkServiceImp()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(photo: Photo?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkServiceImp()
        let presenter = DetailPresenter(view: view, networkService: networkService, photo: photo)
        view.presenter = presenter
        return view
    }
}
