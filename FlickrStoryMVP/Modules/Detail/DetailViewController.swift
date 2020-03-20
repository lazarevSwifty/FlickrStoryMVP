import UIKit
import SDWebImage

class DetailViewController: UIViewController, ViewSpecificController {
    typealias RootView = DetailView
    

    var presenter: DetailViewPresenterProtocol!
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setImage()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setImage(photo: Photo?) {
        let photoURL = UrlConfigure.configure(photo: photo)
        view().imageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        view().imageView.sd_setImage(with: photoURL)
    }
}
