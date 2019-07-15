import UIKit

class WeightViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var txtGrams: UITextField!
    @IBOutlet weak var txtKilograms: UITextField!
    @IBOutlet weak var txtPounds: UITextField!
    @IBOutlet weak var txtOunces: UITextField!
    
    private let weightState = WeightState()
    
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)
    
    enum Units {
        case gram, kilogram, pound, ounce
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.setUIComponents()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    @IBAction func onChange(_ sender: UITextView) {
        var unitName: Units
        switch sender {
        case txtGrams:
            unitName = .gram
        case txtOunces:
            unitName = .ounce
        case txtPounds:
            unitName = .pound
        case txtKilograms:
            unitName = .kilogram
        default:
            print("Unknown")
            unitName = .gram
        }
        
        self.accessQueue.sync{
            if let val = sender.text {
                if let v = Double(val){
                    self.convertUnit(type: unitName, value: v)
                }else {
                    self.setUIComponents()
                }
                
            } else {
                self.setUIComponents()
            }
        }
      
     
    }
    
    func convertUnit(type: Units, value: Double){
        switch(type){
        case .gram:
            self.weightState.grams = value
            self.txtKilograms.text = String(self.weightState.kilograms)
            self.txtPounds.text = String(self.weightState.pounds)
            self.txtOunces.text = String(self.weightState.ounces)
            
        case .ounce:
            self.weightState.ounces = value
            self.txtPounds.text = String(self.weightState.pounds)
            self.txtKilograms.text = String(self.weightState.kilograms)
            self.txtGrams.text = String(self.weightState.grams)
           
        case .pound:
            self.weightState.pounds = value
            self.txtKilograms.text = String(self.weightState.kilograms)
            self.txtOunces.text = String(self.weightState.ounces)
            self.txtGrams.text = String(self.weightState.grams)
            
        case .kilogram:
            self.weightState.kilograms = value
            self.txtPounds.text = String(self.weightState.pounds)
            self.txtOunces.text = String(self.weightState.ounces)
            self.txtGrams.text = String(self.weightState.grams)
          
        }
    }
    func setUIComponents() {
        self.txtGrams.text = ""
        self.txtKilograms.text = ""
        self.txtPounds.text = ""
        self.txtOunces.text = ""
    }
}

