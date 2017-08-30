//
//  ItemVC.swift
//  DreamList
//
//  Created by Hardik Wason on 27/08/17.
//  Copyright © 2017 Hardik Wason. All rights reserved.
//

import UIKit
import CoreData

class ItemVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var title_insert: UITextField!
    @IBOutlet weak var price_insert: UITextField!
    @IBOutlet weak var description_insert: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var img: UIImageView!
    
    var stores = [Store]()
    var itemtype = [ItemTyoe]()
    var itemToedit : Item?
    var imagepicker : UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let itembutton = self.navigationController?.navigationBar.topItem {
            itembutton.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }

        picker.delegate = self
        picker.dataSource = self
//        let types1 = ItemTyoe(context: context)
//        types1.type = "Electronics"
//        let types2 = ItemTyoe(context: context)
//        types2.type = "Automobile"
//        let types3 = ItemTyoe(context: context)
//        types3.type = "Shoes"
//        let types4 = ItemTyoe(context: context)
//        types4.type = "Watch"
//        let types5 = ItemTyoe(context: context)
//        types5.type = "Destination"
//        let types6 = ItemTyoe(context: context)
//        types6.type = "Clothes"

       let store1 = Store(context: context)
        store1.name = "Ebay"
        let store2 = Store(context: context)
        store2.name = "Amazon"
        let store3 = Store(context: context)
        store3.name = "Best Buy"
        let store4 = Store(context: context)
        store4.name = "Myntra"
        let store5 = Store(context: context)
        store5.name = "Mobikwik"
        let store6 = Store(context: context)
        store6.name = "Flipkart"
        ad.saveContext()
        fetchstores()
        
        if itemToedit != nil {
            Loaditemdata()
        }
        
        imagepicker = UIImagePickerController()
        imagepicker.delegate = self

        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return stores.count}
        else {
            return itemtype.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0{
        let store = stores[row]
               return store.name
        }
        else {
            let typo = itemtype[row] ///////2nd row
            return typo.type
        }
    }
    
    
    func fetchstores()
    {
        let fetchrequest : NSFetchRequest<Store> = Store.fetchRequest()
        let fetchrequest2 : NSFetchRequest<ItemTyoe> = ItemTyoe.fetchRequest() //2nd row
        
        do {
            self.stores = try context.fetch(fetchrequest)
            self.itemtype = try context.fetch(fetchrequest2) /// 2nd row
        }
        catch {
            //////
        }
        
        
        
    }
    
    @IBAction func save_btn(_ sender: UIButton) {
        
        var item : Item!
        let pic = Image(context: context)
        pic.image = img.image
        
        
        if itemToedit == nil {
            item = Item(context: context)
        }
        else {
            item = itemToedit
        }
        
        item.toImage = pic
        if let title = title_insert.text
        {
            item.title = title
        }
        
        if let price = price_insert.text
        {
            item.price = ( price as NSString).doubleValue
        }
        if let details = description_insert.text
        {
            item.details = details
        }
        
        item.toStore = stores[picker.selectedRow(inComponent: 0)]
        item.toItemType = itemtype[picker.selectedRow(inComponent: 1)]
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func Loaditemdata()
    {
        if let item = itemToedit
        {
            title_insert.text = item.title
            price_insert.text = "\(item.price)"
            description_insert.text = item.details
            img.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        picker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                }while(index < stores.count)
            }
            
            if let typo = item.toItemType {
                var index = 0
                repeat {
                    let t = itemtype[index]
                    if t.type == typo.type {
                        picker.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    index += 1
                } while(index < itemtype.count)
            }
            
        }
        
    }
    
    
    @IBAction func delete_btn(_ sender: UIBarButtonItem) {
        
        if itemToedit != nil {
            
            context.delete(itemToedit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func img_tap(_ sender: UIButton) {
        
        present(imagepicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            img.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    

}
