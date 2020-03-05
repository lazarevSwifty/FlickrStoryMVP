import UIKit
import SDWebImage

protocol DetailViewProtocol: AnyObject {
    func setImage(photo: Photo?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkService, photo: Photo?)
    func setImage()
}

class DetailPresenter: DetailViewPresenterProtocol {

    let networkService: NetworkService!
    weak var view: DetailViewProtocol?
    var photo: Photo?

    required init(view: DetailViewProtocol, networkService: NetworkService, photo: Photo?) {
        self.view = view
        self.networkService = networkService
        self.photo = photo
    }
    
    func setImage() {
        self.view?.setImage(photo: photo)
    }
    
}


