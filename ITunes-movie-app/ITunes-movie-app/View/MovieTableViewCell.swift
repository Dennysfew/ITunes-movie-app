//
//  MovieTableViewCell.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 17.10.2023.
//

import UIKit
import Kingfisher
import CoreData

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var vContent: UIView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var genreNameLb: UILabel!
    @IBOutlet var releaseDateLb: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    
    private let imageModificationSize = "/250x250bb.jpg"
    private let imageDefaultSize = "/100x100bb.jpg"
    
    var movie: Movie?
    
    var managedObjectContext: NSManagedObjectContext?
    
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
        self.movie = movie
        movieTitle.text = movie.trackCensoredName
        genreNameLb.text = movie.primaryGenreName
        releaseDateLb.text = movie.releaseYear
        let modifiedURL = modifyImageURL(movie.artworkUrl100)
        moviePoster.kf.setImage(with: URL(string: modifiedURL))
    }
    
    func configure(savedMovie: SavedMovie) {
        movieTitle.text = savedMovie.trackCensoredName
        genreNameLb.text = savedMovie.primaryGenreName
        releaseDateLb.text = savedMovie.releaseYear
        if let posterUrl = savedMovie.posterUrl {
            moviePoster.kf.setImage(with: URL(string: modifyImageURL(posterUrl)))
        }
    }
    
    private func modifyImageURL(_ url: String) -> String {
        return url.replacingOccurrences(of: imageDefaultSize, with: imageModificationSize)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let movie = movie else {
            return
        }
        
        let movieTitle = movie.trackCensoredName
        
        if isMovieInCoreData(movieTitle) {
            showAlreadySelectedAlert()
        } else {
            addMovieToCoreData(movie)
        }
    }
    
    private func showAlreadySelectedAlert() {
        let alertController = UIAlertController(
            title: "Movie Already Selected",
            message: "You have already added this movie to your favorites.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let viewController = getViewController() {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func isMovieInCoreData(_ movieTitle: String) -> Bool {
        let context = CoreDataStack.shared.viewContext
        
        let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackCensoredName == %@", movieTitle)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error fetching from Core Data: \(error)")
            return false
        }
    }
    
    private func addMovieToCoreData(_ movie: Movie) {
        let context = CoreDataStack.shared.viewContext
        
        let savedMovie = SavedMovie(context: context)
        savedMovie.trackCensoredName = movie.trackCensoredName
        savedMovie.primaryGenreName = movie.primaryGenreName
        savedMovie.releaseYear = movie.releaseYear
        savedMovie.posterUrl = movie.artworkUrl100
        
        CoreDataStack.shared.saveContext()
    }
    
    @objc func shareButtonTapped() {
        if let movieURLString = movie?.previewURL, let movieURL = URL(string: movieURLString) {
            let activityViewController = UIActivityViewController(activityItems: [movieURL], applicationActivities: nil)
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

