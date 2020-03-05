import UIKit
import SDWebImage

protocol MainViewProtocol: AnyObject {
    func succes()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkService)
    func obtainImages()
    var flickrPhotos: [Photo]? {get set}
}

class MainPresenter: MainViewPresenterProtocol {

    let networkService: NetworkService
    
    weak var view: MainViewProtocol?
    var flickrPhotos: [Photo]?

    required init(view: MainViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        obtainImages()
    }
    
    func obtainImages() {
        networkService.fetchImages(completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.flickrPhotos = photos
                    self?.view?.succes()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
}


