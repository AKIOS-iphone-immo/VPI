//
//  VPIAppDelegate.h
//  VPI
//
//  Created by Christophe Bergé on 03/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Recherche.h"
#import "Agence.h"

@class VPIViewController, Recherche;

@interface VPIAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController *tabBarController;
    UIImageView *imagePresentation;
    Recherche *rechercheView;
    Agence *agenceView;

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet VPIViewController *viewController;

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) Recherche *rechercheView;
@property (nonatomic, retain) Agence *agenceView;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end
