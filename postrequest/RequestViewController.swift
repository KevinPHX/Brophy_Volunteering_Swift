//
//  RequestViewController.swift
//  postrequest
//
//  Created by Kevin Yin on 7/18/18.
//  Copyright © 2018 Kevin Yin. All rights reserved.
//

import UIKit
struct Request: Codable {
    let subject: String
    let topic: String
    let addinfo: String?
}
class RequestViewController: UIViewController {

    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var addinfoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func submitPost(post: Request, completion:((Error?) -> Void)?) {
        let username = UserDefaults.standard.string(forKey: "username")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "brophyvolunteer.club"
        urlComponents.path = "/users/request/" + username! as! String
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
                print("response: ", utf8Representation)
                
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        let userSubject = subjectTextField.text
        let userTopic = topicTextField.text
        let userAddInfo = addinfoTextField.text
        func displayMyAlertMessage(userMessage:String){
            var myAlert = UIAlertController(title: "Alert", message:  userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
        }
        if ((userSubject?.isEmpty)! || (userTopic?.isEmpty)!){
            displayMyAlertMessage(userMessage: "Please fill in the subject and topic fields");
            return;
        }
        let myPost = Request(subject: userSubject!, topic: userTopic!, addinfo: userAddInfo!)
        
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
