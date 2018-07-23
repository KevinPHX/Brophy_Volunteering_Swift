//
//  MyPendingRequestViewController.swift
//  postrequest
//
//  Created by Kevin Yin on 7/17/18.
//  Copyright © 2018 Kevin Yin. All rights reserved.
//

import UIKit

struct Cancel: Codable { }

class MyPendingRequestViewController: UITableViewController {
    var tableViewData = [cellData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = UserDefaults.standard.string(forKey: "username")
        self.myrequest(for: username! as! String)
        // Do any additional setup after loading the view.
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
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
                let tutorees = try JSONDecoder().decode([Tutoree].self, from: data)
                print(tutorees)
                for tutoree in tutorees {
                    let Title: String = "Name: " + tutoree.tutoreename
                    if tutoree.addinfo == nil {
                        let addinfo = "None"
                        self.tableViewData.append(cellData(opened: true, title: Title, sectionData: ["Subject: " + tutoree.subject, "Topic: " + tutoree.topic, "Additional Information: " + addinfo, "Email: " + tutoree.tutoreeemail, "Phone Number: " + tutoree.tutoreephonenumber, "Cancel Request"]))
                    } else {
                        let addinfo = tutoree.addinfo!
                        self.tableViewData.append(cellData(opened: true, title: Title, sectionData: ["Subject: " + tutoree.subject, "Topic: " + tutoree.topic, "Additional Information: " + addinfo, "Email: " + tutoree.tutoreeemail, "Phone Number: " + tutoree.tutoreephonenumber, "Cancel Request"]))
                    }
                    
                }
                self.tableView.reloadData()
                
            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row-1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            let myPost = Cancel()
            
            submitPost(post: myPost) { (error) in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            let swiftColor = UIColor(red: 1, green: 126/255, blue: 121/255, alpha: 1)
            cell.backgroundColor = swiftColor
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.white
        }
    }
    func submitPost(post: Cancel, completion:((Error?) -> Void)?) {
        let username = UserDefaults.standard.string(forKey: "username")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "brophyvolunteer.club"
        urlComponents.path = "/users/cancel/" + username! as! String
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
