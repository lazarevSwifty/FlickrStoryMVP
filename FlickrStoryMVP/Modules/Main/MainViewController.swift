import UIKit

final class MainViewController: UIViewController, ViewSpecificController {
    typealias RootView = MainView
    
    
    var presenter: MainViewPresenterProtocol!
    let sectionInsets = UIEdgeInsets(top: 0,
    left: UIScreen.main.bounds.width * 0.1,
    bottom: UIScreen.main.bounds.width * 0.1,
    right: UIScreen.main.bounds.width * 0.1)
    
    let itemsPerRow: CGFloat = 2
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().frame = UIScreen.main.bounds
        
        view().collectionView.delegate = self
        view().collectionView.dataSource = self
        
        setNavBar()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
        } else {
            print("portrait")
        }
    }
    
    func setNavBar() {
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButton(sender:)))
        navigationItem.rightBarButtonItem = refreshItem
    }
    
    @objc func refreshButton(sender: UIBarButtonItem) {
        presenter.refreshData()
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
              
        //let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        //let availableWidth = collectionView.frame.width - paddingSpace
        let availableWidth = UIScreen.main.bounds.width * 0.35
        //let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: availableWidth, height: availableWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width * 0.1

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
        view().collectionView.reloadData()
    }
    
    
}
