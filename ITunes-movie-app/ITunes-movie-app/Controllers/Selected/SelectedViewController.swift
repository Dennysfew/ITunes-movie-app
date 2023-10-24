//
//  SelectedViewController.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 17.10.2023.
//

import UIKit
import CoreData

class SelectedViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    
    // MARK: - Properties
    
    var savedMovies: [SavedMovie] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selected"
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSavedMovies()
        updateEmptyView()
    }
    
    // MARK: - Setup Functions
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    private func setupNavigationBar() {
        let trashBinImage = UIImage(systemName: "trash.fill")
        let removeAllButton = UIBarButtonItem(image: trashBinImage, style: .plain, target: self, action: #selector(removeAllButtonTapped))
        navigationItem.rightBarButtonItem = removeAllButton
    }
    
    // MARK: - Data Fetching
    
    private func fetchSavedMovies() {
        let context = CoreDataStack.shared.viewContext
        
        do {
            savedMovies = try context.fetch(SavedMovie.fetchRequest())
            tableView.reloadData()
            updateEmptyView()
        } catch {
            print("Error fetching saved movies: \(error)")
        }
    }
    
    // MARK: - Actions
    
    @objc func removeAllButtonTapped() {
        let context = CoreDataStack.shared.viewContext
        
        for savedMovie in savedMovies {
            context.delete(savedMovie)
        }
        
        do {
            try context.save()
            savedMovies.removeAll()
            tableView.reloadData()
            updateEmptyView()
        } catch {
            print("Error removing saved movies: \(error)")
        }
    }
    
    // MARK: - Helper Functions
    
    private func updateEmptyView() {
        emptyView.isHidden = !savedMovies.isEmpty
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension SelectedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let savedMovie = savedMovies[indexPath.row]
        cell.configure(savedMovie: savedMovie)
        
        return cell
    }
}
