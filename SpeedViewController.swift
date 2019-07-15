import UIKit

class SpeedViewController: UIViewController {

    @IBOutlet weak var txtMPS: UITextField!
    @IBOutlet weak var txtFPM: UITextField!
    @IBOutlet weak var txtKMPH: UITextField!
    @IBOutlet weak var txtMPH: UITextField!
    
    private let speedState = SpeedState()
    
    enum Units {
        case mps, fpm , kmph, mph
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
        case txtMPH:
            unitName = .mph
        case txtFPM:
            unitName = .fpm
        case txtMPS:
            unitName = .mps
        case txtKMPH:
            unitName = .kmph
        default:
            unitName = .mph
        }

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
    
    func convertUnit(type: Units, value: Double) {
        switch type {
        case .mph:
     
            self.speedState.mph = value
            self.txtKMPH.text = String(self.speedState.kmph)
            self.txtMPS.text = String(self.speedState.mps)
            self.txtFPM.text = String(self.speedState.fpm)
            
        case .kmph:
            
            self.speedState.kmph = value
            self.txtMPH.text = String(self.speedState.mph)
            self.txtMPS.text = String(self.speedState.mps)
            self.txtFPM.text = String(self.speedState.fpm)
            
        case .fpm:
        
            self.speedState.fpm = value
            self.txtKMPH.text = String(self.speedState.kmph)
            self.txtMPS.text = String(self.speedState.mps)
            self.txtMPH.text = String(self.speedState.mph)
            
        case .mps:
        
            self.speedState.mps = value
            self.txtKMPH.text = String(self.speedState.kmph)
            self.txtMPH.text = String(self.speedState.mph)
            self.txtFPM.text = String(self.speedState.fpm)
            
        }
    }
    
    func setUIComponents() {
        self.txtFPM.text = ""
        self.txtMPH.text = ""
        self.txtMPS.text = ""
        self.txtKMPH.text = ""
    }

}
