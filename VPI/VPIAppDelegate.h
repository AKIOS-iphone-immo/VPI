//
//  VPIAppDelegate.h
//  VPI
//
//  Created by Christophe Bergé on 03/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VPIViewController;

@interface VPIAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet VPIViewController *viewController;

@end
