/*
 MIT License
 
 Copyright (c) 2019 Thales DIS
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
 rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
 Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 IMPORTANT: This source code is intended to serve training information purposes only.
 Please make sure to review our IdCloud documentation, including security guidelines.
 */

import UIKit
import CoreLocation

// RiskEngine backend URL
let riskEngineURL = "// PLACEHOLDER: Server URL"

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager? = nil
    
    @IBOutlet weak var labelSDKVersion: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for location permissions.
        self.getUserAccessPermissionToUseLocationService()
        
        <#Code Placeholder - Configuration#>
        
        <#Code Placeholder - Initialization#>
        
        <#Code Placeholder - Prefetch#>
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Display SDK version information.
        let sdkInfo = GAHCore.getSDKVersionInfo()
        let formattedVersion = String.init(format: "%@\n%@\n%@\n%@", sdkInfo!.getName(),
                                           sdkInfo!.getVersion(),
                                           sdkInfo!.getBuild(),
                                           sdkInfo!.isDebugMode() ? "Debug" : "Release")
        
        self.labelSDKVersion.text = formattedVersion
        self.labelStatus.text = nil
    }
    
    deinit {
        // It is recommended to call this method during a transaction screen exit
        // where startPrefetchSignals() was called previously.
        <#Code Placeholder - Stop Prefetch#>
    }
    
    // MARK: - Private Helpers
    
    /* This triggers the popup to give permission to access location
    while using the app Location is one of the signal category which
    is collected and used for risk calcualation
    */
    func getUserAccessPermissionToUseLocationService() {
        <#Code Placeholder - Permissions#>
    }
    
    private func processPrefetchStatusResponse(_ statusCode: Int, _ statusMsg: String?) {
        // Log return value status.
        print("Request prefetch finished with status code: \(statusCode) and message: \(statusMsg ?? "<No Message>")")
        
        // Make sure that we have all signals prefetched.
        <#Code Placeholder - Request Visit Id#>
    }
    
    private func processVisitIDResponse(_ success: Bool, _ value: String?) {
        // In this Lab we want to simple display some visual result, so UI thread is also handy.
        DispatchQueue.main.sync {
            // Display result on screen.
            self.labelStatus.setTextAnimated(value)
            
            if (success) {
                // Do something with Visit ID.
                // ...
                // ...
            }
        }
    }
    
    // MARK: - User Interface
    
    @IBAction func onButtonPressedSampleAction(_ sender: UIButton) {
        // Show direct response to UI.
        // Full application will have some sort of dialog fragment / loading indicator.
        self.labelStatus.setTextAnimated("Processing...")
        
        // Listen to prefetch status
        <#Code Placeholder - Prefetch Status#>
    }
    
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Handle permission status change.
        // This method must be implemented (can be empty) in order to get system permission dialog.
    }
}
