//
//  ViewController.swift
//  testAstro
//
//  Created by Hemant on 26/11/24.
//

import UIKit
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var movies: [MovieData] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieListCollectionCell.self, forCellWithReuseIdentifier: MovieListCollectionCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func fetchMovies() {
        MovieService().fetchMovieData { [weak self] movies in
            guard let movies = movies else { return }
            self?.movies = movies
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

//dataSource Methods
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionCell.identifier, for: indexPath) as? MovieListCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}
