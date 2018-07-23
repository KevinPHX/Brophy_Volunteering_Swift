//
//  PastRequestsViewController.swift
//  postrequest
//
//  Created by Kevin Yin on 7/17/18.
//  Copyright © 2018 Kevin Yin. All rights reserved.
//

import UIKit

struct cellData {
    var opened: Bool
    let title: String
    let sectionData: [String]
}



class PastRequestsViewController: UITableViewController {
    var tableViewData = [cellData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = UserDefaults.standard.string(forKey: "username")
        self.pastrequests(for: username! as! String)
        // Do any additional setup after loading the view.
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
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
                let tutorees = try JSONDecoder().decode([Tutoree].self, from: data)
                print(tutorees)
                for tutoree in tutorees {
                    let Title: String = tutoree.timerequest + " Subject: " + tutoree.subject
                    if tutoree.addinfo == nil {
                        let addinfo = "None"
                        self.tableViewData.append(cellData(opened: false, title: Title, sectionData: ["Topic: " + tutoree.topic,"Time Request was Accepted: " + tutoree.timeaccept!,"Name of Tutor: " + tutoree.tutorname!, "Additional Information: " + addinfo, "Email: " + tutoree.tutoremail!, "Phone Number: " + tutoree.tutorphonenumber!]))
                    } else {
                        let addinfo = tutoree.addinfo!
                         self.tableViewData.append(cellData(opened: false, title: Title, sectionData: ["Topic: " + tutoree.topic,"Time Request was Accepted: " + tutoree.timeaccept!,"Name of Tutor: " + tutoree.tutorname!, "Additional Information: " + addinfo, "Email: " + tutoree.tutoremail!, "Phone Number: " + tutoree.tutorphonenumber!]))
                    }

                }
                self.tableView.reloadData()
                
            } catch let jsonErr{
                print("Error:", jsonErr)
            }
            }.resume()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row-1]
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
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
