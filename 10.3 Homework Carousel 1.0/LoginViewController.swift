//
//  LoginViewController.swift
//  10.3 Homework Carousel 1.0
//
//  Created by Becker, Kathrine V on 10/2/16.
//  Copyright © 2016 Becker, Kathrine V. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            self.buttonParentView.frame.origin.y = self.buttonInitialY + self.buttonOffset
            self.scrollView.contentOffset.y = self.scrollView.contentInset.bottom
            
            
            // Any code you put in here will be called when the keyboard is about to display
        }
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to hide
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func didPressBack(_ sender: AnyObject) {
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func didPressSignIn(_ sender: AnyObject) {
        print("User did press sign in button")
        
        if nameField.text!.isEmpty || passwordField.text!.isEmpty {
            print("User didn't enter name or password")
            let alertController = UIAlertController(title: "One does not simply", message: "enter without an ID", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Okay I guess", style: .cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        } else {
            loadingView.startAnimating()
        
            delay(2) {
                self.checkPassword()
                self.loadingView.stopAnimating()
            }
        }
    }
    
    
    func checkPassword() {
        if nameField.text == "Becker" && passwordField.text == "Password" {
            print("User entered correct name")
            performSegue(withIdentifier: "signInSegue", sender: nil)
        } else {
            print("User entered incorrect name")
            let alertController = UIAlertController(title: "Woops!", message: "That name and password combo didn't match our records. Want to try again?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true)
        }
        
    }

    
    
}
