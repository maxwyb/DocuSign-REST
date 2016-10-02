//
//  ViewController.swift
//  DocuSign-REST
//
//  Created by Yingbo Wang on 10/1/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit
import Alamofire

let userVerification = ["Username":"maxwyb@hotmail.com", "Password":"ab12cd34", "IntegratorKey":"7da1c5dc-5fae-4df9-80b4-4dbeffd8db34"]

var userJSON: NSString?

var userHeader: HTTPHeaders?


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var label: UILabel?
    
    @IBAction func buttonClicked(sender: AnyObject) {
        calculateUserHeader()
        getAccountURL()
        requestEnvelop()
    }
    
    func calculateUserHeader() {
        /* generate a string header with three nested fields */
        var data: Data? // NSDictionary to NSData Serialization
        do {
            data = try JSONSerialization.data(withJSONObject: userVerification)
        } catch {
            data = nil
        }
        
        if let data = data {
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue) // NSData to NSString
            if let json = json {
                //debugPrint(json)
                userJSON = json
                userHeader = [ "X-DocuSign-Authentication": json as String]
            }
        }
        
    }
    
    func getAccountURL() {

        /* Parse the userID */
        Alamofire.request("https://demo.docusign.net/restapi/v2/login_information", headers: userHeader).responseJSON { response in
            
            /*
            debugPrint("----------response.data----------")
            debugPrint(response.data)
            debugPrint("---------------------------------")
            debugPrint("----------response.description----------");
            debugPrint(response.description)
            debugPrint("---------------------------------")
            debugPrint("----------response.result----------");
            debugPrint(response.result)
            debugPrint("---------------------------------")
            debugPrint("----------response.result.value----------");
            debugPrint(response.result.value)
            */

            let loginAccounts = response.result.value as! NSDictionary
            /*
            let loginAccounts_login = loginAccounts["loginAccounts"]
            print(loginAccounts_login)
            */
            /*
            let dicExample = ["Apple": 1, "Banana": 12]
            print(dicExample);
            */
            let loginAccounts_login = (loginAccounts["loginAccounts"]! as! NSArray).mutableCopy() as! NSMutableArray
            let loginAccounts_login_dict = loginAccounts_login[0] as! NSDictionary
            let userID = loginAccounts_login_dict["userId"]
            
            self.label!.text = userID as! String
            
            /*
            var jsonParsed: [String:String]?
            do {
                try jsonParsed = JSONSerialization.jsonObject(with: response.result, options: []) as? [String:String]
            } catch let error as NSError {
                print(error)
            }
            */
        }
    }

    func requestEnvelop() {
        /* send HTTP post request for document signature */
        let postWeb: String = "https://demo.docusign.net/restapi/v2/accounts/1703061/envelopes"
        
        let headers: HTTPHeaders = ["X-DocuSign-Authentication" : userJSON as! String, "Accept" : "application/json", "Content-Type" : "application/json"]
        
        let parameters: Parameters = ["X-DocuSign-Authentication" : userJSON as! String,
                                      "Accept" : "application/json",
                                      "Content-Type" : "application/json",
                                      "emailSubject" : "DocuSign REST API from Swift 3!",
                                      "emailBlurb" : "Shows how to create and send an envelope from a document.",
                                      "recipients" : [
                                        "signers" : [[
                                            "email" : "maxwyb@gmail.com",
                                            "name" : "Max W.",
                                            "recipientId" : "1",
                                            "routingOrder" : "1"
                                        ]]
                                      ],
                                      "documents" : [[
                                        "documentId" : "1",
                                        "name" : "sd-hacks.pdf",
                                        "documentBase64" : "<base64 encoded document bytes>"
                                       ]],
                                      "status" : "sent"
        ]
        
        Alamofire.request(postWeb, method: .post, headers: headers).responseJSON { response in
            debugPrint("--------header starts.------------------------")
            debugPrint(response)
            debugPrint("--------header ends; parameter starts.--------")
        }
        
        Alamofire.request(postWeb, method: .post, parameters: parameters).responseJSON { response in
            debugPrint(response)
        }
         
    }
}

