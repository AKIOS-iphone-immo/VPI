//
//  Recherche.h
//  ParisDemeures
//
//  Created by Christophe Bergé on 16/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChoixVilleController2.h"
#import "SelectionTypeBienController.h"
#import "SelectionSurfaceController.h"
#import "SelectionNbPiecesController.h"
#import "SelectionBudgetController.h"
#import "AfficheListeAnnoncesController2.h"
#import "Intervalle.h"
//#import "Utility.h"
#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "VenteLocation.h"
#import "XMLParser.h"
#import "BudgetController.h"

@class ASINetworkQueue;

@interface Recherche : UIViewController {
	NSMutableArray *tableauAnnonces1;
	NSString *critere;
    NSMutableDictionary *critereWeb;
    BOOL isConnectionErrorPrinted;
    ASINetworkQueue *networkQueue;
}

@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;
@property (nonatomic, copy) NSString *critere;
@property (nonatomic, copy) NSMutableDictionary *critereWeb;

-(UIImage *) getImage:(NSString *)cheminImage;
- (BOOL) sendRequest;
- (void) sauvegardeRecherches;

@end
