//
//  ViewController.swift
//  Device State Test
//
//  Created by Developer Skromanglobal on 18/07/22.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var image_one: UIImageView!
    
    @IBOutlet weak var image_two: UIImageView!
    
    @IBOutlet weak var image_three: UIImageView!
    
    var fan_state : String!
    var master : String!
    
    var fan1 : String!
    var fan2 : String!
    var master_text : String!
    
    var test_array = [Any]()
    
    var my_unique_id = "SKSL_1xGLn8"
    
    var managedObjextContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var device_state_list_load = [DeviceList]()
    
    var test_L_state : String!
    
    
    var my_l_state = [String]()
    var my_dest_button = [String]()
    var my_config_dim = [String]()
    var my_config_button = [String]()
    var my_fan_state = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        Get_Device_State()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fan", style: .done, target: self, action: #selector(FanButton))
        
        navigationController?.navigationBar.tintColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
    }
    
    
    @objc func FanButton() {
        
        
        let Navigate_To_Second_VC : SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        
        self.navigationController?.pushViewController(Navigate_To_Second_VC, animated: true)
    }
    
    //MARK: ===== SAVE TO CORE DATA =====
    
    func SaveData() {
        do {
            
            try managedObjextContext.save()
        }
        catch {
            print("Error To Save Data")
        }
    }
    
    
    
    //MARK: ===== DELETE DEVICE DATA FROM CORE DATA =====
    func DeleteDeviceDataFunc() {
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceList")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReq)
        
        do {
            try managedObjextContext.execute(deleteRequest)
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    func device_state_Fetch() {
        
        let request = DeviceList.fetchRequest()
        
        do {
        
            device_state_list_load = try managedObjextContext.fetch(request)
            
            
            
            DispatchQueue.main.async { [self] in
                
                
                for fan in self.device_state_list_load {
                    
                    self.fan_state = fan.f_state
                    
                    if self.fan_state == "N/A" {
                        
                        self.image_one.image = UIImage(named: "master")
                        
                        self.fan1 = "N/A"
                        self.fan2 = "N/A"
                        self.master_text = "MASTER"
                        
                        print("Fan:>",fan1!)
                        print("Fan:>",fan2!)
                        print(master_text!)
                    }
                    
                    else if self.fan_state == "1" {
                     
                        self.image_one.image = UIImage(named: "Fan_1")
                        self.image_two.image = UIImage(named: "master")
                        
                        self.fan1 = "FAN 1"
                        self.fan2 = "N/A"
                        self.master_text = "MASTER"
                        
                        print("Fan:>",fan1!)
                        print("Fan:>",fan2!)
                        print(master_text!)
                        
                        
                    }
                    
                    else if self.fan_state == "2" {
                     
                        self.image_one.image = UIImage(named: "Fan_1")
                        self.image_two.image = UIImage(named: "Fan_1")
                        self.image_three.image = UIImage(named: "master")
                        
                        self.fan1 = "FAN 1"
                        self.fan2 = "FAN 2"
                        self.master_text = "MASTER"
                        
                        print("Fan:>",fan1!)
                        print("Fan:>",fan2!)
                        print(master_text!)
                        
                    }
                    
                }
                
            }
        }
        
        catch {
            print(error.localizedDescription)
            
        }
    }
    
}

extension ViewController {
    
    
    func Get_Device_State() {
        
        
        //        let unique_id = my_unique_id
        
        let device_parameters : Parameters = [
            
            //            "unique_id": unique_id
            "unique_id": "SKSL_1xGLn8"
        ]
        
        
        AF.request("http://3.7.18.55:3000/skroman/devicestate/unique_id", method: .post, parameters: device_parameters, encoding: JSONEncoding.default, headers:  nil).response { [self] response in
            
            
            switch response.result {
                
            case .success(let data):
                do {
                    
                    let jsonOne = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if
                        
                        let parseJson = jsonOne,
                        let result = parseJson["result"] as? NSDictionary,
                        let deviceStateUid = result["deviceStateUid"] as? String,
                        let deviceUid = result["deviceUid"] as? String,
                        let unique_id = result["unique_id"] as? String,
                        let modelNo = result["modelNo"] as? String,
                        let dest_button = result["dest_button"] as? String,
                        let fan_dest = result["fan_dest"] as? String,
                        let config_dim = result["config_dim"] as? String,
                        let config_buttons = result["config_buttons"] as? String,
                        let child_lock_l = result["child_lock_l"] as? String,
                        let child_lock_f = result["child_lock_f"] as? String,
                        let child_lock_m = result["child_lock_m"] as? String,
                        let master = result["master"] as? String,
                        let L_state = result["L_state"] as? String,
                        let L_speed = result["L_speed"] as? String,
                        let F_state = result["F_state"] as? String,
                        let F_speed = result["F_speed"] as? String,
                        
                            
                            let l_state_test = result["L_state"] as? String
                            
                            
                            
                    {
                        let separate = Array(l_state_test)
                        
                        let saveDeviceStateList = DeviceList(context: self.managedObjextContext)
                        
                        let saveDevice_l_StateList = L_State(context: self.managedObjextContext)
                        
                        saveDeviceStateList.deviceStateUid = deviceStateUid
                        saveDeviceStateList.deviceUid = deviceUid
                        saveDeviceStateList.unique_id = unique_id
                        saveDeviceStateList.modelNo = modelNo
                        saveDeviceStateList.dest_button = dest_button
                        saveDeviceStateList.fan_dest = fan_dest
                        saveDeviceStateList.config_dim = config_dim
                        saveDeviceStateList.config_buttons = config_buttons
                        saveDeviceStateList.child_lock_l = child_lock_l
                        saveDeviceStateList.child_lock_f = child_lock_f
                        saveDeviceStateList.child_lock_m = child_lock_m
                        saveDeviceStateList.master = master
                        saveDeviceStateList.l_state = L_state
                        saveDeviceStateList.l_speed = L_speed
                        saveDeviceStateList.f_state = F_state
                        saveDeviceStateList.f_speed = F_speed
                        
                        
                        
                        let separate_l_state = L_state.map(String.init)
                        let separate_dest_button = dest_button.map(String.init)
                        let separate_config_dim = config_dim.map(String.init)
                        let separate_config_button = config_buttons.map(String.init)
                        let separate_f_state = F_state.map(String.init)
                        
                        for Separate_L_State in separate_l_state {
                            
                            my_l_state.append(Separate_L_State)
                            
                            
                        }
                        
                        
                        for Separate_Dest_Button in separate_dest_button {
                            
                            my_dest_button.append(Separate_Dest_Button)
                        
                            
                        }
                        
                        for Separate_Config_Dim in separate_config_dim {
                            
                            my_config_dim.append(Separate_Config_Dim)
                            
                        }
                        
                        for Separate_Config_Button in separate_config_button {
                            
                            my_config_button.append(Separate_Config_Button)
                            
                        }
                        
                        
                        for Separate_F_State in separate_f_state {
                            
                            my_fan_state.append(Separate_F_State)
                            
                        }
                        
                   }
                    
                    self.DeleteDeviceDataFunc()
                    self.SaveData()
                    self.device_state_Fetch()
                    self.tableView.reloadData()
                    //                    self.second_table_view.reloadData()
                    
                }
                
                
                catch {
                    
                    
                    
                }
            case .failure(_):
                print("Error")
            }
            
        }
    }
    
    
    
}


extension ViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return my_dest_button.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        //        cell.label.text = my_dest_button[indexPath.row]
        cell.confid_dim_value = my_config_dim[indexPath.row]
        cell.l_state_value = my_l_state[indexPath.row]
        cell.config_button_value = my_config_button[indexPath.row]
        cell.Hard_Button_label.text = my_config_button[indexPath.row]
        
        
        
        if cell.l_state_value == "1"{
            
            
            
            cell.imagess.image = cell.imagess.image?.withRenderingMode(.alwaysTemplate)
            cell.imagess.tintColor = UIColor.green
        }
        
        else {
            
            cell.imagess.image = cell.imagess.image?.withRenderingMode(.alwaysTemplate)
            cell.imagess.tintColor = UIColor.red
        }
        
        if cell.config_button_value == "L" {
            
            cell.imagess.image = UIImage(named: "Light")
            
        }
        else if cell.config_button_value == "D" {
            
            cell.imagess.image = UIImage(named: "horizontal_cutains")
        }
        
        if cell.imagess.image == UIImage(named: "Light") && cell.confid_dim_value == "1" {
            
            cell.dim_value_image.image = UIImage(systemName: "star.fill")
            
        }
        
        else {
            cell.dim_value_image.image = UIImage(systemName: "")
            
        }
        
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        
        
        cell.imagess.image = UIImage(systemName: "homepod")
        
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
