//
//  XMLParser.h
//  ParisDemeures
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Annonce.h"
#import "VPIAppDelegate.h"

@class VPIAppDelegate, Annonce;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Annonce *uneAnnonce;
	VPIAppDelegate *appDelegate;
}

- (XMLParser *) initXMLParser;

@end
