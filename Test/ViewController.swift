//
//  ViewController.swift
//  Test
//
//  Created by Mihael Isaev on 23/08/16.
//  Copyright © 2016 Mihael Isaev. All rights reserved.
//

import UIKit
import RealmSwift

class RMovements: Object {
    dynamic var name: String!
    dynamic var _quantity: Double = 0
    var quantity: Double {
        get {
            return _quantity / 1000
        }
        set {
            _quantity = newValue * 1000
        }
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

class ViewController: UIViewController {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check()
    }
    
    func createOrUpdateObject() {
        do {
            try realm.write({
                if let m = realm.objects(RMovements).filter("name=%@", "john").last {
                    print("before update: \(m)")
                    m.quantity = 9
                    realm.add(m, update: true)
                    print("after update: \(m)")
                } else {
                    let m = RMovements()
                    m.name = "john"
                    m.quantity = 2
                    realm.add(m, update: true)
                    print("created")
                }
            })
        } catch _ {}
    }
    
    @IBAction func check() {
        createOrUpdateObject()
        if let m = realm.objects(RMovements).filter("name=%@", "john").last {
            print("check: \(m)")
        }
    }
}

