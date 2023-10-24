//
//  ProfileViewController.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 17.10.2023.
//

import UIKit
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var usernameLb: UILabel!
    @IBOutlet var contentV: UIView!
    @IBOutlet var userLocationLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        // Fetch user data (default behavior)
        fetchUserData()
    }
    
    @IBAction func didLogOutTapped(_ sender: Any) {
        logOutUser()
    }
    
    private func logOutUser() {
        // Delete the token from the keychain
        KeychainWrapper.standard.removeObject(forKey: "token")
        
        // Redirect the user to the sign-in view
        navigateToSignIn()
    }
    
    private func navigateToSignIn() {
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    private func configureUI() {
        userImageView.layer.cornerRadius = 20.0
        
        contentV.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
    
    private func fetchUserData() {
        // Here should be implemented the API call and data parsing here in the future
        // For now, we use default values
        
        userImageView.image = UIImage(systemName: "person.fill")
        usernameLb.text = "Elena Helen"
        userLocationLb.text = "New York, USA"
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
