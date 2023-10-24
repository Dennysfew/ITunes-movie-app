//
//  HomeViewController.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 17.10.2023.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var placeholderLabel: UILabel!
    
    var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Debouncer for search requests
    var searchDebouncer: DispatchWorkItem?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Placeholder label setup
        placeholderLabel.text = "Type something"
        placeholderLabel.textColor = .lightGray
        placeholderLabel.isHidden = true
        view.addSubview(placeholderLabel)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    private func fetchMovies(withName movieName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(movieName)&entity=movie"
        
        NetworkDataFetch.shared.fetchMovie(urlString: urlString) { [weak self] movieResult, error in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
            } else if let movieResult = movieResult {
                self?.movies = movieResult.results
                print("Fetched \(self?.movies.count ?? 0) movies")
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespaces)
        
        if trimmedText.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        
        // Cancel the previous debounce work item if it exists
        searchDebouncer?.cancel()
        
        // Create a new work item with a configurable delay
        let searchDelay = 0.5
        let newDebouncer = DispatchWorkItem { [weak self] in
            self?.fetchMovies(withName: trimmedText)
        }
        
        searchDebouncer = newDebouncer
        
        // Schedule the work of search with the specified delay
        DispatchQueue.main.asyncAfter(deadline: .now() + searchDelay, execute: newDebouncer)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        
        cell.configure(movie: movie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovieURLString = movies[indexPath.row].trackViewURL ?? ""
        openMovieInBrowser(urlString: selectedMovieURLString)
    }
    
    private func openMovieInBrowser(urlString: String) {
        if let movieURL = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: movieURL)
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
}
