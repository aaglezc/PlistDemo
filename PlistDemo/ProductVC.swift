//
//  ProductVC.swift
//  PlistDemo
//
//  Created by Kirti Parghi on 10/19/17.
//  Copyright © 2017 Kirti Parghi. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    var path:String!
    var array = NSMutableArray()

    @IBOutlet weak var txtFieldProductPrice: UITextField!
    @IBOutlet weak var txtFieldProductName: UITextField!
    @IBOutlet weak var txtFieldProductID: UITextField!
    
    // VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //    readInformationPlist()
        
    }
    
    func readInformationPlist() {
        if let bundlePath = Bundle.main.path(forResource: "SamplePropertyList", ofType: "plist") {
            let dictionary = NSMutableDictionary(contentsOfFile: bundlePath)
            
            print(dictionary!.description)
        }
    }
    
    //Action --- ADD PRODUCT
    fileprivate func writeToThePlist() {
        array = NSMutableArray(contentsOfFile: path)!
        
        
        let dictProduct = NSMutableDictionary()
        dictProduct["productid"] = txtFieldProductID.text
        dictProduct["productname"] = txtFieldProductName.text
        dictProduct["productprice"] = txtFieldProductPrice.text
        
        array.add(dictProduct)
        array.write(toFile: path, atomically: true)
        
        showMessage()
    }
    
    @IBAction func btnAddProductTapped(_ sender: UIButton) {
        
        
        // Searching for all the path in the project
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as Array
        
        // get the path of document directory
        let documentPath = paths[0] as String
        
        // appending property list file name at the end of document directory path
        path = documentPath.appending("ProductPlist")
        
        // for locating or pointing to the property list file in document directory
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: path) {
            if let bundlePath = Bundle.main.path(forResource: "ProductPlist", ofType: "plist") {
                array = NSMutableArray(contentsOfFile: bundlePath)!
                do {
                    
                    // copying property list in the document directory
                    try fileManager.copyItem(at: URL(fileURLWithPath: bundlePath), to: URL(fileURLWithPath: path))
                    
                } catch {
                    print("copy failure")
                }
                ////////////////////////
                
                writeToThePlist()
            }
            else {
                print("product plist not found")
            }
        }
        else {
            print("file product plist already exist at path")
            
            writeToThePlist()
        }
    }
    
    func showMessage() {
        let alrt = UIAlertController(title: "Message", message: "Product is added sucessfully.", preferredStyle: .alert)
        alrt.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alrt.dismiss(animated: true, completion: nil)
        }))
        self.present(alrt, animated: true, completion: nil)
    }
    
    //Action --- LIST PRODUCTS
    @IBAction func btnListProductsTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "productlistSegue", sender: self)
    }

    // MEMORY MANAGEMENT
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
