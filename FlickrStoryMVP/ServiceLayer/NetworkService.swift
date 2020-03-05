import Foundation

protocol NetworkService: AnyObject {
    func fetchImages(completion: @escaping (Result<[Photo], Error>) -> Void)
}

final class NetworkServiceImp: NetworkService {
    func fetchImages(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: Constants.flickrUrl) else { return completion(.failure(NSError(domain: "wrong url", code: 001, userInfo: nil))) }
        
        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(response.photos.photo))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }.resume()
    }
}
