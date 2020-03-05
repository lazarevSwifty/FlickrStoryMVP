import Foundation

class UrlConfigure {
    static func configure(photo: Photo?) -> URL? {
        if
         let farm = photo?.farm,
         let server = Int(photo?.server ?? "nil"),
         let id = Int(photo?.id ?? "nil"),
         let secret = photo?.secret {
            let url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            let sdUrl = URL(string: url)
            return sdUrl
        } else {
            return nil
            
        }
    }
}

