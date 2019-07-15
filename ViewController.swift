//
//  ViewController.swift
//  BMI Calc With History
//
//  Created by Lenin S on 18/05/19.
//  Copyright © 2019 Technomotus. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var barr: UILabel!
    
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var bmi: UILabel!
    @IBOutlet weak var genderSelect: UISegmentedControl!
    @IBOutlet weak var high: UILabel!
    
    var isHistory = false
    var historyDatas = NSDictionary()
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var suggestion: UISwitch!
    var a:Int = 1
    @IBAction func gencerChoose(sender: AnyObject) {
        
        if(genderSelect.selectedSegmentIndex == 0)
        {
            gender.text = "Bed";
            a = 1
        }
        if(genderSelect.selectedSegmentIndex == 1)
        {
            gender.text = "Living";
            a = 2
        }
        if(genderSelect.selectedSegmentIndex == 2)
        {
            gender.text = "Kitchen";
            a = 3
        }
        if(genderSelect.selectedSegmentIndex == 3)
        {
            gender.text = "2nd Floor";
            a = 4
        }
        
        
    }
    
    
    var highh:Int = 8
    @IBOutlet weak var heightValue: UISlider!
    @IBOutlet weak var heightNum: UILabel!
    @IBAction func height(sender: UISlider) {
        highh = Int(sender.value)
        heightNum.text = "\(highh)"
    }
    @IBOutlet weak var stepper: UIStepper!
    
    var agee:Int = 2
    @IBAction func stepperValue(sender: UIStepper) {
        age.text = Int(sender.value).description
        agee = Int(stepper.value)
    }
    
    @IBOutlet weak var suggest: UILabel!
    
    
    var w:Double = 1.0
    
    @IBAction func weightInput(sender: UITextField) {
        if (weight.text != nil)
        {
            w = Double(weight.text!)!
        }
        else
        {w = 1.0}
    }
    override func viewDidLayoutSubviews() {
        
        self.setGradientCrossBackground(topColor: UIColor.init(red: 0/258, green: 214/258, blue: 25/258, alpha: 1.0), bottomColor: UIColor.init(red: 86/258, green: 145/258, blue: 200/258, alpha: 1.0))
    }
    
    func setGradientCrossBackground(topColor: UIColor, bottomColor: UIColor)
    {
        
        if self.view.layer.sublayers != nil
        {
            for layer in self.view.layer.sublayers!
            {
                if layer.accessibilityValue == "gradient"
                {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
        
        
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = self.view.bounds
        gradientColor.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientColor.locations = [0.0, 1.0]
        gradientColor.startPoint = CGPoint.init(x: 0, y: 0)
        gradientColor.endPoint = CGPoint.init(x: 1, y: 1)
        gradientColor.accessibilityValue = "gradient"
        self.view.layer.insertSublayer(gradientColor, at: 0)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    var s: Int = 0
    var emptys:String = " "
    var somes: String = " "
    var counter: Int = 0
    @IBAction func suggestS(sender: UISwitch) {
       
    }
    
    
    var bminum:Double = 0.0
    @IBAction func calculate(sender: AnyObject) {
       calculateBMI()
    }
    func calculateBMI () {
        
        if nameTxt.text == "".trimmingCharacters(in: .whitespaces){
            barr.text = "Enter the square feet to continue"
        }
        else {
            
            var btu = Float(0.0)
            let area = Float(nameTxt.text ?? "0.0")
            if a == 1 || a == 2{
                btu = area! * 30
            } else if a == 3 || a == 4{
                btu = area! * 40
            }
            
            if agee > 2 {
                let x = Float(agee) - 2
                btu += x * 600
            }
            if highh > 8 {
                let x = Float(highh) - 8
                btu += x * 1000
            }
            bmi.text = "\(btu)"
            
        }
//        else
//            if (a != 1)
//            {
//                counter = 1
//                bminum = round(100*(10000*w/Double(highh*highh))/100)
//                if (bminum > 5.0 && bminum < 80.0 )
//                {
//                    if (bminum <= 18.5)
//                    {
//                        bmi.text = "\(bminum)"
//                        somes = "Underweight"
//                        suggest.text = somes
//                        barr.text = " "
//                    }
//                    else if (bminum > 18.5 && bminum <= 24.9)
//                    {
//                        bmi.text = "\(bminum)"
//                        somes = "Normal weight"
//                        suggest.text = somes
//                        barr.text = " "
//                    }
//                    else if (bminum > 24.9 && bminum <= 29.9)
//                    {
//                        bmi.text = "\(bminum)"
//                        somes = "Overweight"
//                        suggest.text = somes
//                        barr.text = " "
//                    }
//                    else
//                    {
//                        bmi.text = "\(bminum)"
//                        somes = "Obesity"
//                        suggest.text = somes
//                        barr.text = ""
//
//                    }
//                }
//                else
//                {
//                    bmi.text = "Wrong Statics!"
//                    barr.text = "If you would like to give details above,\n this app can help you to impove your health"
//                    counter = 4
//                }
//            }
//            else
//            {
//                counter = 3
//                barr.text = "Gender is not selected"
//                suggest.text = " "
//        }
    }
    @IBOutlet weak var resetB: UIButton!
    
    @IBAction func resetPressed(sender: AnyObject) {
        gender.text = "Bed"
        genderSelect.selectedSegmentIndex=0
        age.text = "2"
        stepper.value=2
        high.text = "8"
        heightValue.value = 8
        weight.text=" "
        bmi.text = "0.0"
        bminum = 0.0
        w=0.0
        highh=8
        a=1
        agee = 2
        s=0
        barr.text = ""
        suggestion.setOn(false,animated: true)
        suggest.text = " "
        somes = " "
        counter = 2
    }
    
    func setUpInitialValues () {
        let dict = historyDatas
       nameTxt.text = dict.value(forKey: "name") as? String ?? ""
        let weigh = dict.value(forKey: "weight") as? String ?? ""
        weight.text = weigh
        let height = dict.value(forKey: "height") as? String ?? ""
        heightNum.text = height
        heightValue.value = Float(height) ?? 0.0
        let gen = dict.value(forKey: "gender") as? String ?? ""
        if gen == "2nd Floor" {
            genderSelect.selectedSegmentIndex = 3
            a = 4
        }else if gen == "Kitchen" {
            genderSelect.selectedSegmentIndex = 2
            a = 3
        } else if gen == "Living" {
            genderSelect.selectedSegmentIndex = 1
            a = 2
        } else {
            genderSelect.selectedSegmentIndex = 0
            a = 1
        }
        gender.text = gen
        let ag = dict.value(forKey: "age") as? String ?? ""
        age.text = ag
        highh = Int(height) ?? 0
        w = Double(weigh) ?? 0.0
        stepper.value = Double(ag) ?? 0.0
        calculateBMI()
    }
    
    override func viewDidLoad() {
        gender.text = "Bed"
        age.text = "2"
        bmi.text = "0.0"
        high.text = "8"
        barr.text = "The most elegant and beautiful\n BTU Calculator ever!"
        stepper.value=2
        suggest.text = " "
        counter = 0
        a=1
        barr.isHidden = true
        if isHistory {
            setUpInitialValues()
        }
        super.viewDidLoad()
//        self.addNavigationBarButton(title: "History", direction: .left)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        let dict = ["name":self.nameTxt.text ?? "-",
                    "height":self.heightNum.text ?? "-",
                    "weight":self.weight.text ?? "-",
                    "age":age.text ?? "-",
                    "gender":gender.text ?? "-"]
        if let arr = UserDefaults.standard.value(forKey: "savedList") as? NSArray {
            let array = arr.mutableCopy() as! NSMutableArray
            array.add(dict)
            UserDefaults.standard.setValue(array, forKey: "savedList")
        } else {
            let array = NSMutableArray()
            array.add(dict)
            UserDefaults.standard.setValue(array, forKey: "savedList")
        }
        Alert()
    }
    func Alert () {
        // create the alert
        let alert = UIAlertController(title: "BTU Calculator", message: "Data Saved Successfully", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    func addNavigationBarButton(title:String,direction:direction){
        switch direction {
        case .left:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style:.plain, target: self, action: #selector(didTapLeft))
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style:.plain, target: self, action: #selector(didTapRight))
        }
    }
    
    @objc func didTapLeft() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapRight() {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    enum direction {
        case right
        case left
    }
}
