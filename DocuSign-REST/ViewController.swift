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

        let userVerification = ["Username":"maxwyb@hotmail.com", "Password":"NNbnds.2009", "IntegratorKey":"7da1c5dc-5fae-4df9-80b4-4dbeffd8db34"]

        var data: Data? // NSDictionary to NSData Serialization
        do {
            data = try JSONSerialization.data(withJSONObject: userVerification)
        } catch {
            data = nil
        }
        
        if let data = data {
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue) // NSData to NSString
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

