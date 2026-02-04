//
//  ViewController.swift
//  UrwayDemoApp
//
//

import UIKit

import SwiftyMenu
import SnapKit
import PassKit
import iOSDropDown
import hosted_ios_plugin

class ViewController: UIViewController , UIScrollViewDelegate
{
    //@IBOutlet var transId: UITextField!
    
    @IBOutlet var amountField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var zipField: UITextField!
    @IBOutlet var currencyField: UITextField!
    @IBOutlet var countryField: UITextField!
    //@IBOutlet var actionField: UITextField!
    @IBOutlet var metadata1: UITextField!
    
    @IBOutlet var metadata2: UITextField!
    @IBOutlet weak var actionDropDown: DropDown!
    
    @IBOutlet var trackIDField: UITextField!
    
 
 
    @IBOutlet var Transid: UITextField!

    
    @IBOutlet var metaadata: UITextField!
    @IBOutlet weak var cardOperdropDwn: DropDown!
    //    @IBOutlet var merchantField: UITextField!
    @IBOutlet var tockenField: UITextField!
//    @IBOutlet var picker: UIPickerView!
    
    @IBOutlet var stateField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var holderField: UITextField!

    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var holderStakView: UIStackView!
    
    @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var topsegmentController: UISegmentedControl!
    
    @IBOutlet var merchantIdentifier: UITextField!
    //    @IBOutlet var topHolderStack: UIStackView!
    
//    var pickerHeightAnchor: NSLayoutConstraint? = nil
    var addressHeightAnchor: NSLayoutConstraint? = nil
    var stateHeightAnchor: NSLayoutConstraint? = nil
    var cityHeightAnchor: NSLayoutConstraint? = nil
    var metadataHeightAnchor: NSLayoutConstraint? = nil
    var countryHeightAnchor: NSLayoutConstraint? = nil
    var cardTokenHeightAnchor:NSLayoutConstraint? = nil
    var merchantIdentifierHeightAnchor:NSLayoutConstraint? = nil
    
    let pickerData = ["Select Card Operation","Add" , "Update" , "Delete"]
    var selectedText = "Add"
    var isTokenEnabled: Bool = true
    var paymentController: UIViewController? = nil
    
    var paymentString: NSString = ""
    var actionCodeId = " "
    var cardOperation = " "
    var isApplePayPaymentTrxn:Bool = false;
    
//    @IBOutlet private weak var dropDown: SwiftyMenu!
//   @IBOutlet private weak var otherView: UIView!
//   let dropDownOptionsDataSource = ["Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1", "Option 1"]
//  let color = ["blue","brown","clear","cyan","gray","green","lightGray","orange","purple","red","white","yellow","black"]

//    var paymentRequest : PKPaymentRequest = {
//    let request = PKPaymentRequest()
//    request.merchantIdentifier = "merchant.testios.com"
//        request.supportedNetworks = [.quicPay, .masterCard, .visa , .amex , .discover , .mada ]
//        request.merchantCapabilities = .capability3DS
//        request.countryCode = "SA"
//        request.currencyCode = "SAR"
//        request.countryCode = countryField.text ?? ""
//        request.currencyCode = currencyField.text ?? ""
//        return request
//     }()
    
    var isSucessStatus: Bool = false
    
    
    var originalSize: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
              
        self.title = "DEMO"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.view.backgroundColor = .white
        self.scrollview.showsVerticalScrollIndicator = false
        self.scrollview.delegate = self
        
        self.originalSize = self.tockenField.frame.height
        self.merchantIdentifier.isHidden=true
        actionDropDown.optionArray=["Select Action","Purchase"," Pre Auth "," Tokenization","Void Purchase","Void Pre Authorization","Refund","Void Refund","Transaction Enquiry"]
       actionDropDown.optionIds = [0,1,4,12,3,9,2,6,10]
      
        actionDropDown.didSelect{(selectedText , index ,id) in
            self.actionCodeId=String(id)
          
        }
        
//        let awesome = Indiapgclass()
//        print(awesome.awesomeFunction())
        
        cardOperdropDwn.optionArray=pickerData
        cardOperdropDwn.didSelect{(selectedText , index ,id) in
//            if self.isTokenEnabled
//            {
//                print("Tokeization enable1")
//                self.enableTokenFieldsAction()
//            }
//            else
//            {
//                print("Tokeization disable2")
//                self.disableTockenFields()
//            }
            
            switch index{
            case 0:
                self.cardOperation = "0"
            case 1:
                self.cardOperation = "A"
            case 2:
                self.cardOperation = "U"
            case 3:
                self.cardOperation = "D"
            default:
                break
            }
            
            print(self.cardOperation)
        }
        
       

        
        prepareConstraints()
        enableTokenFields()
        
        segmentController.setTitle("Present", forSegmentAt: 0)
        segmentController.setTitle("Not Present", forSegmentAt: 1)
        
        
        topsegmentController.setTitle("Normal Pay", forSegmentAt: 0)
        topsegmentController.setTitle("Apple Pay", forSegmentAt: 1)
        
        

        
        if  UIScreen.main.traitCollection.userInterfaceStyle == .light
        {
            self.view.backgroundColor = .white
        }
        else
        {
            self.view.backgroundColor = .black
        }
       
//        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(Main.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
       let index =  topsegmentController.selectedSegmentIndex
        UIView.animate(withDuration: 0.3) {
//            self.topHolderStack.alpha = (index == 1) ? 0 : 1
//            self.topHolderStack.isHidden = index == 1
            
            if index == 0
            {
                print(index)
              
                self.merchantIdentifier.isHidden=true
                
            }
            else
            {
                //instrumenttype="APPLEPAY"
                self.merchantIdentifier.isHidden=false
                //self.disableTokenFieldsAction()
                
            }
            
            self.view.layoutIfNeeded()
            
        }

        self.isTokenEnabled = index == 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    

    override func viewWillAppear(_ animated: Bool) {

        
        if  UIScreen.main.traitCollection.userInterfaceStyle == .light {
            self.view.backgroundColor = .white
        } else {
            self.view.backgroundColor = .black
        }
    }
    
    @IBAction func btnClicked() {
        let isApplePayPayment = topsegmentController.selectedSegmentIndex == 1
         
         print("In Payment Button ")
         if isApplePayPayment {
             print("In Payment Button1 ")
            
             self.isApplePayPaymentTrxn=true;
             self.applePaymentconfigureSDK()
             self.applePayButtonAction()
             
         } else {
             self.merchantIdentifierHeightAnchor?.constant = 0
             print("In Payment Button 2")
             self.isApplePayPaymentTrxn=false;
             self.normalPaymentconfigureSDK()
             self.initializeSDK()
            
         }
    }
//       @IBAction func urWayTapped() {
//        let isApplePayPayment = topsegmentController.selectedSegmentIndex == 1
//
//        print("In Payment Button ")
//        if isApplePayPayment {
//            print("In Payment Button1 ")
//
//            self.isApplePayPaymentTrxn=true;
//            self.applePaymentconfigureSDK()
//            self.applePayButtonAction()
//        } else
//        {
//            self.merchantIdentifierHeightAnchor?.constant = 0
//            print("In Payment Button 2")
//            self.isApplePayPaymentTrxn=false;
//            self.normalPaymentconfigureSDK()
//            self.initializeSDK()
//
//        }
//
//    }
//
    
    fileprivate func initializeSDK() {
        UWInitialization(self) { (controller , result) in
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            print("initialSDK")
            self.navigationController?.pushViewController(nonNilController, animated: true)
        }

    }
    
  
    
    func applePaymentconfigureSDK() {
        
        let terminalId = "TER5392572"
        let password = "TER25123653637313042804"
        let merchantKey = "f1aa70c3de58cbd8b132b50799f4ea7b120168a43b6c20ab99298064a7df77e1"
        let url = "https://pg.alinmapay.com.sa/Transactions/v2/payments/pay-request"
     
        UWConfiguration(password: password, merchantKey: merchantKey, terminalID: terminalId , url: url )
    }
    
    
    func normalPaymentconfigureSDK() {
       
        let terminalId = "TER2233893"
        let password = "TER26011944544352675243"
        let merchantKey = "c6db90a9d31cd620a34b8f70bed27b1a35a82a34a13d01c1d4befa45a634e899"
        let url = "https://pg.alinmapay.com.sa/SB_Transactions/v2/payments/pay-request"
    
        

        self.paymentString = ""
        
        UWConfiguration(password: password , merchantKey: merchantKey , terminalID: terminalId , url: url )
        
    }
    
    

    fileprivate func applePayButtonAction()
    {
        self.paymentString = ""
        UWInitialization(self)
        {
            (controller , result) in
            self.paymentController = controller
            guard let _ = self.paymentController
            else {
                self.presentAlert(resut: result)
                return
            }
        }
        
        isSucessStatus = false
        let floatAmount = Double(amountField.text ?? "0") ?? .zero

            let request = PKPaymentRequest()
            request.merchantIdentifier = merchantIdentifier.text ?? ""
            request.supportedNetworks = [.quicPay, .masterCard, .visa , .amex , .discover , .mada ]
            request.merchantCapabilities = .capability3DS
	
            request.countryCode = countryField.text ?? ""
            request.currencyCode = currencyField.text ?? ""

            request.paymentSummaryItems = [PKPaymentSummaryItem(label: " Test ",amount: NSDecimalNumber(floatLiteral: floatAmount) )]
        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        if controller != nil
        {
            controller!.delegate = self
            present(controller!, animated: true, completion: nil)
        }
    }
}


//MARK: - APPLE PAYMENT CODE
extension ViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        isSucessStatus ? self.initializeSDK() : nil
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        self.paymentString = UWInitializer.generatePaymentKey(payment: payment)
        isSucessStatus = true
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}


extension ViewController {
    
    fileprivate func prepareConstraints() {
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: (self.holderStakView.frame.height  + 100))
//      self.picker.translatesAutoresizingMaskIntoConstraints = false
//      self.picker.dataSource = self
//      self.picker.delegate = self
//      self.pickerHeightAnchor = picker.heightAnchor.constraint(equalToConstant: 0)
        self.cardTokenHeightAnchor = tockenField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.stateHeightAnchor = stateField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.cityHeightAnchor = cityField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.metadataHeightAnchor = cityField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.countryHeightAnchor = countryField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.addressHeightAnchor = addressField.heightAnchor.constraint(equalToConstant: self.originalSize)

//        self.pickerHeightAnchor?.isActive = true
        self.cardTokenHeightAnchor?.isActive = true
        self.stateHeightAnchor?.isActive = true
        self.cityHeightAnchor?.isActive = true
        self.metadataHeightAnchor?.isActive = true
        self.countryHeightAnchor?.isActive = true
        self.addressHeightAnchor?.isActive = true
        self.view.layoutIfNeeded()
    }
    
//    @IBAction func switchOnePressed(_ sender: UISwitch) {
//        if sender.isOn
//        {
//            isTokenEnabled = true
//            enableTokenFields()
//        }
//        else
//        {
//            isTokenEnabled = false
//            disableTokenFieldsAction()
//        }
//    }

    
    func disableTokenFieldsAction() {
        print("enabl")


        self.cityHeightAnchor?.constant = 0
        self.addressHeightAnchor?.constant = 0
        self.stateHeightAnchor?.constant = 0
    
        self.cityField.text = ""
        self.countryField.text = ""
        self.addressField.text = ""
        self.stateField.text = ""
        self.tockenField.text = ""
        
      //  self.cardTokenHeightAnchor?.constant = 0
        
        UIView.animate(withDuration: 0.5)
        {
            self.view.layoutIfNeeded()
        }
   }
    
    func enableTokenFields()
    {
        self.cityHeightAnchor?.constant = self.originalSize
        self.countryHeightAnchor?.constant = self.originalSize
        self.addressHeightAnchor?.constant = self.originalSize
        self.stateHeightAnchor?.constant = self.originalSize
        self.cardTokenHeightAnchor?.constant = self.originalSize

         UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}


extension ViewController: Initializer {

  func prepareModel() -> UWInitializer {
   
      print(self.paymentString)
        let model =  UWInitializer.init(
                                       amount: amountField.text ?? "",
                                       email: emailField.text ?? "",
                                       zipCode: zipField.text ?? "",
                                       currency: currencyField.text ?? "",
                                       country: countryField.text ?? "" ,
                                       actionCode: actionCodeId,
                                       trackIdCode: trackIDField.text ?? "",
                                       city: self.cityField.text ?? "",
                                       // udf4: isApplePayPaymentTrxn ? "ApplePay" : "",
                                       // PaymentToken
                                       // udf5:  isApplePayPaymentTrxn ? paymentString : "" ,
//                                     // udf5: paymentString,
//                                       PaymentToken : self.paymentString as String,
                                       address: addressField.text ,
                                       createTokenIsEnabled: isTokenEnabled,
//                                     merchantIP: merchantField.text ?? "",
                                       cardToken: tockenField.text,
                                       
                                       cardOper: self.cardOperation ,
                                       state: stateField.text ,
                                       transid : Transid.text ,
                                       merchantidentifier: merchantIdentifier.text ?? "",
                                       tokenizationType: "\(segmentController.selectedSegmentIndex)",metaData: metadata1.text ?? ""
        )

        return model
    }

    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        switch result {
        case .sucess:
            print("PAYMENT SUCESS")
            DispatchQueue.main.async {
                self.navigateTOReceptPage(model: model)
            }
            
        case.failure:
            
            print("PAYMENT FAILURE")
            DispatchQueue.main.async {
                self.navigateTOReceptPage(model: model)
            }
            
          
        case .mandatory(let fieldName):
            print(fieldName)
            break
        }
    }
    
    func navigateTOReceptPage(model: PaymentResultData?) {
        self.paymentController?.navigationController?.popViewController(animated: true)
        print("Navigate to receipt")
        let controller = ReceptConfiguration.setup()
        controller.model = model
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
}

extension ViewController {
    func presentAlert(resut: paymentResult) {
          var displayTitle: String = ""
          var key: mandatoryEnum = .amount

          switch resut {
          case .mandatory(let fields):
              key = fields
          default:
              break
          }
          
          switch  key {
          case .amount:
              displayTitle = "Amount"
          case.country:
              displayTitle = "Country"
          case.action_code:
              displayTitle = "Action Code"
          case.currency:
              displayTitle = "Currency"
          case.email:
              displayTitle = "Email"
          case.trackId:
              displayTitle = "TrackID"
          case .tokenID:
            displayTitle = "TokenID"
          case .cardOperation:
            displayTitle = "Token Operation"
          case .transid:
              displayTitle = "Transaction ID "
          }
          
          let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }
     
}

