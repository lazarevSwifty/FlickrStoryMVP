import UIKit
import SDWebImage

final class MainCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutImage()
    }
    
    func layoutImage(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
            self.imageView.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.imageView.sd_setImage(with: sdUrl)
        }
        
    }
}
