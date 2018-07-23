//
//  LoginPageViewController.swift
//  postrequest
//
//  Created by Kevin Yin on 7/11/18.
//  Copyright © 2018 Kevin Yin. All rights reserved.
//


import UIKit
struct Post: Codable {
    let username: String
    let password: String
}


struct stuff {
    let username: String
    let email: String
}

class LoginPageViewController: UIViewController {
    struct stuff {
        var username: String
        let email: String
    }
    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    var Username: String = ""
    var Users = [User]()
    var Tutorees = [Tutoree]()
    var Stuff = stuff(username: "", email: "")
    func viewDidLoad(for JWT: String) {
        super.viewDidLoad()
        let jsonURLString = "https://brophyvolunteer.club/users/profile"
        
        guard let url = URL(string: jsonURLString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = JWT
        //headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) {(data, response, err) in
            guard let data =  data else {return}
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print (dataAsString)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                let user = (json as AnyObject)["user"]
                print(user! as Any)
                let email = (user as AnyObject)["email"]
                print(email! as! String)
                let username = (user as AnyObject)["username"]
                print(username! as! String)
                
                UserDefaults.standard.set(username as! String, forKey: "username")
                UserDefaults.standard.set(email as! String, forKey: "email")
                UserDefaults.standard.set((user as AnyObject)["firstname"] as! String, forKey: "firstname")
                UserDefaults.standard.set((user as AnyObject)["lastname"] as! String, forKey: "lastname")
                UserDefaults.standard.set((user as AnyObject)["grade"] as! String, forKey: "grade")
                UserDefaults.standard.set((user as AnyObject)["phonenumber"] as! String, forKey: "phonenumber")
                UserDefaults.standard.set((user as AnyObject)["school"] as! String, forKey: "school")
                UserDefaults.standard.synchronize()
                

                self.match(for: username as! String)
                self.pastrequests(for: username as! String)
                self.acceptedrequest(for: username as! String)
                self.myrequest(for: username as! String)
                //                let users = try JSONDecoder().decode(User.self, from: data)
                //                print(users)
                
                
            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()
        // Do any additional setup after loading the view.
    }
  
    
    func match(for username: String){
        let jsonURLString = "https://brophyvolunteer.club/users/match/" + username
        
        guard let url = URL(string: jsonURLString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) {(data, response, err) in
            guard let data =  data else {return}
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print (dataAsString)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)

                //let tutoree = try JSONDecoder().decode([Tutoree].self, from: data)
                //print(tutoree)
                
                
                
                
            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()
    }
    
    func pastrequests(for username: String){
        let jsonURLString = "https://brophyvolunteer.club/users/mypastrequests/" + username
        
        guard let url = URL(string: jsonURLString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) {(data, response, err) in
            guard let data =  data else {return}
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print (dataAsString)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)

            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()

    }
    
    func myrequest(for username: String){
        let jsonURLString = "https://brophyvolunteer.club/users/myrequest/" + username
        
        guard let url = URL(string: jsonURLString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) {(data, response, err) in
            guard let data =  data else {return}
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print (dataAsString)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                
            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()
    }
    
    
    func acceptedrequest(for username: String){
        let jsonURLString = "https://brophyvolunteer.club/users/myacceptedrequests/" + username
        
        guard let url = URL(string: jsonURLString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) {(data, response, err) in
            guard let data =  data else {return}
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print (dataAsString)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                
            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func submitPost(post: Post, completion:((Error?) -> Void)?) {
        let userUsername = userUsernameTextField.text
        let userPassword = userPasswordTextField.text
        let myPost = Post(username: userUsername!, password: userPassword!)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "brophyvolunteer.club"
        urlComponents.path = "/users/authenticate"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(post)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                //print("response: ", utf8Representation)
                let substring = utf8Representation
                print("response: ", substring)
                let firstpart = substring.dropFirst(25)
                print(firstpart)
                let JWT = firstpart.dropLast(2)
                print(JWT)
                if substring.range(of:"true") != nil {
                    print("true")
                    self.viewDidLoad(for: String(JWT))
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true, completion: nil)
                }
                
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userUsername = userUsernameTextField.text
        let userPassword = userPasswordTextField.text
        let myPost = Post(username: userUsername!, password: userPassword!)
        
        submitPost(post: myPost) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
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
