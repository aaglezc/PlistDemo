//
//  ProductListVC.swift
//  PlistDemo
//
//  Created by Kirti Parghi on 10/19/17.
//  Copyright © 2017 Kirti Parghi. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayProducts:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProductListFromPlist()
    }

    func fetchProductListFromPlist() {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as Array
        let documentPath = paths[0] as String
        let path = documentPath.appending("ProductPlist")
        
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: path) {
            if let bundlePath = Bundle.main.path(forResource: "ProductPlist", ofType: "plist") {
                do {
                    try fileManager.copyItem(at: URL(fileURLWithPath: bundlePath), to: URL(fileURLWithPath: path))
                } catch {
                    print("copy failure")
                }
            }
            else {
                print("product plist not found")
            }
        }
        else {
            print("file product plist already exist at path")
        }
        arrayProducts = NSMutableArray(contentsOfFile: path)!
        print("load productlist.plist is \(arrayProducts.description)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrayProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! UITableViewCell
        let dictProduct = arrayProducts[indexPath.row] as! NSMutableDictionary
        cell.textLabel?.text = dictProduct.value(forKey: "productname") as? String
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
