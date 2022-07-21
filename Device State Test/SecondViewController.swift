//
//  SecondViewController.swift
//  Device State Test
//
//  Created by Developer Skromanglobal on 21/07/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var fan_image: UIImageView!
    @IBOutlet weak var fan_speed_bar: UIProgressView!
    
    var device_state_data = [DeviceList]()
    var vc = ViewController()
    
    
    var my_speed : String!
    var my_fan_state : String!
    
    
    var managedObjextContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        device_state_Fetch()
    }
    
    
    @objc func RefreshButton() {
        
        
        
    }
    func device_state_Fetch() {
        
        let request = DeviceList.fetchRequest()
        
        do {
          
            device_state_data = try managedObjextContext.fetch(request)
            
            DispatchQueue.main.async { [self] in
                
                
                for fan_state in device_state_data {
                    
                    self.my_fan_state = fan_state.f_state
                    
                    if self.my_fan_state == "1" {
                        
                        fan_image.image = UIImage(named: "Fan_1")
                        fan_speed_bar.isHidden = false
                    }
                    
                    else if self.my_fan_state == "N/A" {
                        
                        
                        fan_image.image = UIImage(named: "")
                        fan_speed_bar.isHidden = true
                    }
                    
                    
                }
                
                
                
                
                for speed in self.device_state_data {

                    print(speed.f_speed!)
                    
                    self.my_speed = speed.f_speed
                    
                    
                    if self.my_speed == "1" {
                        
                        fan_speed_bar.setProgress(0.250, animated: true)
                    }
                    
                    
                    else if self.my_speed == "2" {
                        
                        fan_speed_bar.setProgress(0.500, animated: true)
                    }
                    
                    
                    else if self.my_speed == "3" {
                        
                        
                        fan_speed_bar.setProgress(0.750, animated: true)
                        
                    }
                    
                    else if self.my_speed == "4" {
                        
                        fan_speed_bar.setProgress(0.1000, animated: true)
                        
                    }
                    
                    else {
                        
                        fan_speed_bar.setProgress(0, animated: true)
                    }

                    }
                
            }
        }
        
        catch {
            print(error.localizedDescription)
            
        }
    }
  
}
