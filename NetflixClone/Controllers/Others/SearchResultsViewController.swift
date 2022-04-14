//
//  SearchResultsViewController.swift
//  NetflixClone
//
//  Created by Ali YILMAZ on 9.04.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate : AnyObject {
    
    func SearchResultsViewControllerDidTapItem(_ viewModel : TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {

    public var titles:[Movie] = [Movie]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        

    }
        public let searchResultsCollectionView : UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10 , height: 200)
            layout.minimumInteritemSpacing = 0
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
            return collectionView
        }()
        
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
        
        
    
    

}

extension SearchResultsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
    
        
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        let titleName = title.original_title ?? ""
        
        APICaller.shared.getMovie(with:titleName) { [weak self] result in
            switch result {
            case.success(let videoElement):
                DispatchQueue.main.async {
                    
                    self?.delegate?.SearchResultsViewControllerDidTapItem(TitlePreviewViewModel(title:title.original_title ?? title.original_name ?? "", youtubeview: videoElement, titleOverview: title.overview ?? ""))
                    
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    

    
}
