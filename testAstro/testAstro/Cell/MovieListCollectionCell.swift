//
//  MovieListCell.swift
//  testAstro
//
//  Created by Hemant on 26/11/24.
//

import UIKit

class MovieListCollectionCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(separatorView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieData) {
        titleLabel.text = movie.Title
        yearLabel.text = movie.Year

        if let url = URL(string: movie.Poster ?? "") {
            fetchImage(from: url) { image in
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }

}

extension MovieListCollectionCell {
    
    private func setupConstraints() {
        // Enable Auto Layout
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // imageConstraints
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 70),
            movieImageView.heightAnchor.constraint(equalToConstant: 70),

            // titleLabel Constraints
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            // yearLabel Constraints
            yearLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            yearLabel.bottomAnchor.constraint(lessThanOrEqualTo: separatorView.topAnchor, constant: -10),

            // separatorView Constraints
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }.resume()
    }
}
