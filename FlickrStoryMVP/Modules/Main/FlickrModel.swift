struct Response: Decodable {
     let photos: FlickrModel
     let stat: String
}
struct FlickrModel: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}
    struct Photo: Decodable {
        let id: String
        let owner: String
        let secret: String
        let server: String
        let farm: Int
        let title: String
        let ispublic: Int
        let isfriend: Int
        let isfamily: Int
        
    }
