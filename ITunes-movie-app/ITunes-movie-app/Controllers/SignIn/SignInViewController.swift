//
//  SignInViewController.swift
//  ITunes-movie-app
//
//  Created by Dennys Izhyk on 24.10.2023.
//

import UIKit
import SwiftKeychainWrapper

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTextField: CustomTextField!
    @IBOutlet var passwordTextField: CustomTextField!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInDidTapped(_ sender: Any) {
        // Ensure that the email and password fields are not empty
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in both email and password.")
            return
        }
        
        // Here should be procedure to authenticate the user
        // Here, we are simulating a successful login for demonstration purposes.
        if email == "demo@example.com" && password == "password" {
            // Successful sign-in
            showAlert(message: "Sign-in successful!")
            handleSuccessfulResponse()
        } else {
            // Failed sign-in
            showAlert(message: "Invalid email or password. Please try again.")
        }
    }
    
    private func handleSuccessfulResponse() {
        // Here should be handling a response from the API
        // For now, it is a simple simulation
        KeychainWrapper.standard.set("logged", forKey: "token")
        
        // Delay for demonstration (2 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.navigateToMainTab()
        }
    }
    
    private func navigateToMainTab() {
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    // Helper function to show an alert with a given message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Sign-In", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
