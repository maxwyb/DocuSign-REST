//
//  ViewController.swift
//  DocuSign-REST
//
//  Created by Yingbo Wang on 10/1/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        getAccountURL()
    }
    
    func getAccountURL() {
        //let parameters: Parameters = []
        let userVerification = ["Username":"maxwyb@hotmail.com", "Password":"NNbnds.2009", "IntegratorKey":"7da1c5dc-5fae-4df9-80b4-4dbeffd8db34"]
        //var error: NSError?
        /*
        if let data = JSONSerialization.dataWithJSONObject(userVerification, options: JSONSerialization.WritingOptions.PrettyPrinted) {
            if let json = NSString(data: data, encoding: NSUTF8StringEncoding) {
                print(json)
                
                let headers: HTTPHeaders = [ "X-DocuSign-Authentication": json]
                Alamofire.request("https://demo.docusign.net/restapi/v2/login_information", headers: headers).responseJSON { response in
                    debugPrint(response)
                }
            }
        }
        */
        /*
        var data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: userVerification, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch _ {
            debugPrint("Error...");
        }
        if let data = data as Data? {
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
            }
        }
        */
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: userVerification, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            data = nil
        }
        if let data = data {
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                debugPrint(json)
                
                let headers: HTTPHeaders = [ "X-DocuSign-Authentication": json as String]
                Alamofire.request("https://demo.docusign.net/restapi/v2/login_information", headers: headers).responseJSON { response in
                    debugPrint(response)
                }
            }
        }

    }

}

