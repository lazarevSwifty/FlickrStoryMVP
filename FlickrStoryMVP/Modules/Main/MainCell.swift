import UIKit
import SDWebImage

final class MainCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = contentView.bounds
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    func configure(photo: Photo?) {
        if
         let farm = photo?.farm,
         let server = Int(photo?.server ?? "nil"),
         let id = Int(photo?.id ?? "nil"),
         let secret = photo?.secret {
            let url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            let sdUrl = URL(string: url)
            self.imageView.sd_setImage(with: sdUrl)
        }
        
    }
}
