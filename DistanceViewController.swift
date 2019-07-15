import UIKit

class DistanceViewController: UIViewController {

    @IBOutlet weak var txtMeters: UITextField!
    @IBOutlet weak var txtFeet: UITextField!
    @IBOutlet weak var txtYards: UITextField!
    @IBOutlet weak var txtKilometers: UITextField!
    @IBOutlet weak var txtMiles: UITextField!
    
    private let distanceState = DistanceState()
    
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)
    
    enum Units {
        case meter, feet, yard, kilometer, mile
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
    
    func setUIComponents() {
        self.txtFeet.text = ""
        self.txtMiles.text = ""
        self.txtYards.text = ""
        self.txtKilometers.text = ""
        self.txtMeters.text = ""
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
       
        print(txtMeters)
        var unitType: Units
        switch sender{
            case txtMeters:
                unitType = .meter
            case txtFeet:
                unitType = .feet
            case txtYards:
                unitType = .yard
            case txtMiles:
                unitType = .mile
            case txtKilometers:
                unitType = .kilometer
            default:
                print("Not found")
                unitType = .meter
        }
        self.accessQueue.sync{
            if let val = sender.text {
                if let v = Double(val){
                    self.convertUnit(type: unitType, value: v)
                }else {
                    self.setUIComponents()
                }
                
            } else {
                self.setUIComponents()
            }
        }
      
    }
    
    
 
    func convertUnit(type: Units, value: Double) {
        switch type {
        case .feet:
          
            self.distanceState.feet = value
            self.txtKilometers.text = String(self.distanceState.kilometers)
            self.txtMeters.text = String(self.distanceState.meters)
            self.txtMiles.text = String(self.distanceState.miles)
            self.txtYards.text = String(self.distanceState.yards)
            
            
        case .meter:
         
            self.distanceState.meters = value
            self.txtKilometers.text = String(self.distanceState.kilometers)
            self.txtFeet.text = String(self.distanceState.feet)
            self.txtMiles.text = String(self.distanceState.miles)
            self.txtYards.text = String(self.distanceState.yards)
            
        case .yard:
          
            self.distanceState.yards = value
            self.txtKilometers.text = String(self.distanceState.kilometers)
            self.txtMeters.text = String(self.distanceState.meters)
            self.txtMiles.text = String(self.distanceState.miles)
            self.txtFeet.text = String(self.distanceState.feet)

        case .kilometer:
          
            self.distanceState.kilometers = value
            self.txtFeet.text = String(self.distanceState.feet)
            self.txtMeters.text = String(self.distanceState.meters)
            self.txtMiles.text = String(self.distanceState.miles)
            self.txtYards.text = String(self.distanceState.yards)
            
        case .mile:
         
            self.distanceState.miles = value
            self.txtFeet.text = String(self.distanceState.feet)
            self.txtMeters.text = String(self.distanceState.meters)
            self.txtKilometers.text = String(self.distanceState.kilometers)
            self.txtYards.text = String(self.distanceState.yards)
            
        }
    }

}
