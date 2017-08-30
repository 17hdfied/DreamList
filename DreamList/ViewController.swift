//
//  ViewController.swift
//  DreamList
//
//  Created by Hardik Wason on 22/08/17.
//  Copyright © 2017 Hardik Wason. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segment_item: UISegmentedControl!
    
    var controller : NSFetchedResultsController<Item>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource  = self
        //generateTest()
        attemptfetch()
    
            }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configurecell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configurecell(cell: ItemCell, indexPath: NSIndexPath)
    {
        let item = controller.object(at: (indexPath as NSIndexPath) as IndexPath)
        cell.configureCell(item: item)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects , objs.count > 0 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemVC"
        {
            if let destination = segue.destination as? ItemVC
            {
                if let item = sender as? Item {
                    destination.itemToedit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func attemptfetch()
    {
        let fetchrequest : NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        
        if segment_item.selectedSegmentIndex == 0 {
             fetchrequest.sortDescriptors = [dateSort]
        } else if segment_item.selectedSegmentIndex == 1 {
            fetchrequest.sortDescriptors = [priceSort]
        } else if segment_item.selectedSegmentIndex == 2 {
            fetchrequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchrequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
         controller.delegate = self
         self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath
            {
                let cell = tableview.cellForRow(at: indexPath) as! ItemCell
                configurecell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
    }
    
}
    
    func generateTest()
    {
        let item = Item(context: context)
        item.title = "Macbook Air 2017"
        item.price = 20000
        item.details = "I really love it from my bottom of my heart, I just want to get started dude"
        
        let item2 = Item(context: context)
        item2.title = "Rolex Watch"
        item2.price = 200000
        item2.details = "I just want the rolex so that i can show off to my homies"
        
        let item3 = Item(context: context)
        item3.title = "Audi 2017"
        item3.price = 80000
        item3.details = "I just want it thats it man, that means a lot to me man"
        ad.saveContext()
    }
    
    
    @IBAction func Segment_btn(_ sender: UISegmentedControl) {
        
        attemptfetch()
        tableview.reloadData()
    }
       
    
    
    
    
    
    
    
    
    
}

