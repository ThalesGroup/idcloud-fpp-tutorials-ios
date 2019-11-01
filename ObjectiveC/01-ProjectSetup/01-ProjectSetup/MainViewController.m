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

#import "MainViewController.h"
#import <GAHRiskEngine/GAHRiskEngine.h>
#import <CoreLocation/CoreLocation.h>
#import "UILabel+Animation.h"

// RiskEngine backend URL
#define kRiskEngineURL @"<#Server URL#>"

@interface MainViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong)   CLLocationManager   *locationManager;
@property (nonatomic, weak)     IBOutlet UILabel    *labelSDKVersion;
@property (nonatomic, weak)     IBOutlet UILabel    *labelStatus;

@end

@implementation MainViewController

// MARK: - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Ask for location permissions.
    [self getUserAccessPermissionToUseLocationService];
    
    <#Code Placeholder - Configuration#>
    
    <#Code Placeholder - Initialization#>
    
    <#Code Placeholder - Prefetch#>
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Display SDK version information.
    GAHMetaInformation *sdkInfo = [GAHCore getSDKVersionInfo];
    NSString *formattedVersion = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",
                                  sdkInfo.getName,
                                  sdkInfo.getVersion,
                                  sdkInfo.getBuild,
                                  sdkInfo.isDebugMode ? @"Debug" : @"Release"];
    
    [_labelSDKVersion   setText:formattedVersion];
    [_labelStatus       setText:nil];
}

- (void)dealloc {
    <#Code Placeholder - Stop Prefetch#>
}

// MARK: - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // Handle permission status change.
    // This method must be implemented (can be empty) in order to get system permission dialog.
}

// MARK: - Private Helpers

/* This triggers the popup to give permission to access location while using the app
Location is one of the signal category which is collected and used for risk calcualation
*/
- (void)getUserAccessPermissionToUseLocationService{
    <#Code Placeholder - Permissions#>
}

- (void)processPrefetchStatusResponse:(NSInteger)statusCode statusMessage:(NSString *) statusMsg {
    // Log return value status.
    NSLog(@"Request prefetch finished with status code: %ld and message: %@", (long)statusCode, statusMsg);

    // Make sure that we have all signals prefetched.
    <#Code Placeholder - Request Visit Id#>
}

/**
 * Process request visit id response. All transactions should be cleared.
 * To keep Lab simple, we will have unified method instead of two callbacks.
 *
 * @param success {@code True} if request was successful, otherwise {@code False}
 * @param value On success it contain Visit ID, otherwise error description.
 */
- (void)processVisitIDResponse:(BOOL)success value:(NSString *)value {
    // ClearTransactionResources needs to be triggered from ui thread if BehavioSec is used.
    // In this Lab we want to simple display some visual result, so UI thread is also handy.
    dispatch_sync(dispatch_get_main_queue(), ^{
        // Display result on screen.
        [self.labelStatus setTextAnimated:value];
        
        if (success) {
            // Do something with Visit ID.
            // ...
            // ...
        }
        
        // Clear transaction resources
        <#Code Placeholder - Clear Transaction Resources#>
    });
}

// MARK: - User Interface

/**
 * User taped on Sample Action button.
 * Show signal collection
 */
- (IBAction)onButtonPressedSampleAction:(UIButton *)sender {
    // Show direct response to UI.
    // Full application will have some sort of dialog / loading indicator.
    [_labelStatus setTextAnimated:@"Processing..."];
    
    // Listen to prefetch status
    <#Code Placeholder - Prefetch Status#>
}

@end
