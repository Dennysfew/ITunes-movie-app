//
//  MovieTableViewCell.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 17.10.2023.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var vContent: UIView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var genreNameLb: UILabel!
    @IBOutlet var releaseDateLb: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    
    @IBOutlet var shareButton: UIButton!
    
    // Define a constant for image size modification
    private let imageModificationSize = "/250x250bb.jpg"
    private let imageDefaultSize = "/100x100bb.jpg"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        selectionStyle = .none
        vContent.layer.cornerRadius = 10
        moviePoster.layer.cornerRadius = 10
    }
    
    func configure(movie: Movie) {
        movieTitle.text = movie.trackCensoredName
        genreNameLb.text = movie.primaryGenreName
        releaseDateLb.text = movie.releaseYear
        
        let modifiedURL = movie.artworkUrl100.replacingOccurrences(of: imageDefaultSize, with: imageModificationSize)
        
        moviePoster.kf.setImage(with: URL(string: modifiedURL))
    }
    
    @objc func shareButtonTapped() {
        if let movieTitle = movieTitle.text,
           let movieImage = moviePoster.image {
            let activityViewController = UIActivityViewController(activityItems: [movieTitle, movieImage], applicationActivities: nil)
            if let viewController = getViewController() {
                viewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    private func getViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
