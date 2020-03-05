import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    let sectionInsets = UIEdgeInsets(top: 50.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0)
    let itemsPerRow: CGFloat = 2
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        mainView.frame = UIScreen.main.bounds
        view.addSubview(mainView)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.flickrPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mainCellIndentifier, for: indexPath) as! MainCell
        cell.configure(photo: presenter.flickrPhotos?[indexPath.row])

        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return sectionInsets
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left

    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presenter.flickrPhotos?[indexPath.row]
        let detailViewController = ModelBuilder.createDetailModule(photo: photo)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func succes() {
        mainView.collectionView.reloadData()
    }
    
    
}
