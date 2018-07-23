//
//  ViewController.swift
//  postrequest
//
//  Created by Kevin Yin on 7/11/18.
//  Copyright © 2018 Kevin Yin. All rights reserved.
//
struct User: Decodable{
    let firstname : String
    let lastname : String
    let username : String
    let phonenumber : String
    let email : String
    let password : String
    let school : String
    let rating : Int
    let grade : String
}

struct Tutoree: Decodable {
    let timerequest : String
    let timeaccept : String?
    let tutoreename : String
    let tutoreeusername : String
    let tutoreeemail : String
    let tutoreephonenumber : String
    let tutoreegrade : String
    let type : String
    let subject : String
    let topic : String
    let addinfo : String?
    let tutorname : String?
    let tutoremail : String?
    let tutorphonenumber : String?
    let tutorgrade : String?
    let rated : Bool
    let read : Bool
}

struct Tutor: Decodable {
    let timerequest : String
    let timeaccept : String
    let tutorname : String
    let tutorusername : String
    let type : String
    let subject : String
    let topic : String
    let addinfo : String?
    let tutoreename : String
    let tutoreeemail : String
    let tutoreephonenumber : String
    let tutoreegrade : String
}

import UIKit

class ViewController: UIViewController {
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
//        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
//        if (!isUserLoggedIn){
//            self.performSegue(withIdentifier: "loginView", sender: self)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if (!isUserLoggedIn){
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(nil, forKey: "username")
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "firstname")
        UserDefaults.standard.set(nil, forKey: "lastname")
        UserDefaults.standard.set(nil, forKey: "grade")
        UserDefaults.standard.set(nil, forKey: "phonenumber")
        UserDefaults.standard.set(nil, forKey: "school")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    
  
}

