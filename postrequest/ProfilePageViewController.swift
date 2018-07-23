//
//  ProfilePageViewController.swift
//  postrequest
//
//  Created by Kevin Yin on 7/16/18.
//  Copyright © 2018 Kevin Yin. All rights reserved.
//

import UIKit



class ProfilePageViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phonenumberLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = UserDefaults.standard.string(forKey: "username")
        let firstname = UserDefaults.standard.string(forKey: "firstname")
        let lastname = UserDefaults.standard.string(forKey: "lastname")
        print(username! as! String)
        self.usernameLabel.text = "Username: " + username! as! String
        self.nameLabel.text = firstname! as! String + " " + lastname! as! String
        let school = UserDefaults.standard.string(forKey: "school")
        self.schoolLabel.text = "School: "+school! as! String
        let grade = UserDefaults.standard.string(forKey: "grade")
        self.gradeLabel.text = "Grade: " + grade! as! String + "th"
        let email = UserDefaults.standard.string(forKey: "email")
        self.emailLabel.text = "Email: " + email! as! String
        let phonenumber = UserDefaults.standard.string(forKey: "phonenumber")
        self.phonenumberLabel.text = "Phone Number: " + phonenumber! as! String
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

}
