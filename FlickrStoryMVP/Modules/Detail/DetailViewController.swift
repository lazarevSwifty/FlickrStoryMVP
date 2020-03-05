import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    let detailView = DetailView()
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setImage()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setImage(photo: Photo?) {
        let photoURL = UrlConfigure.configure(photo: photo)
        DispatchQueue.main.async {
            self.detailView.imageView.sd_setImage(with: photoURL)
        }
    }
}
