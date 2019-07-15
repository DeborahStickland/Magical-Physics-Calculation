import UIKit

class TermperatureViewController: UIViewController {

    @IBOutlet weak var txtCelsius: UITextField!
    @IBOutlet weak var txtFahrenheit: UITextField!
    @IBOutlet weak var txtKelvin: UITextField!
    
    private let tempState = TemperatureState()
    
    
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)
    
    enum Units {
        case celsius, fahrenheit, kelvin
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
        var tempType: Units
        switch sender{
        case txtKelvin:
            tempType = .kelvin
        case txtCelsius:
            tempType = .celsius
        case txtFahrenheit:
            tempType = .fahrenheit
        default:
            tempType = .kelvin
        }
        
        self.accessQueue.sync{
            if let val = sender.text {
                if let v = Double(val){
                    self.convertUnit(type: tempType, value: v)
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
        case .celsius:
    
            self.tempState.celsius = value
            self.txtFahrenheit.text = String(self.tempState.fahrenheit)
            self.txtKelvin.text = String(self.tempState.kelvin)
        
        case .kelvin:

            self.tempState.kelvin = value
            self.txtFahrenheit.text = String(self.tempState.fahrenheit)
            self.txtCelsius.text = String(self.tempState.celsius)
           
        case .fahrenheit:

            self.tempState.fahrenheit =  value
            self.txtCelsius.text = String(self.tempState.celsius)
            self.txtKelvin.text = String(self.tempState.kelvin)
    
        }
    }
    
    func setUIComponents() {
        self.txtKelvin.text = ""
        self.txtCelsius.text = ""
        self.txtFahrenheit.text = ""
    }
}

