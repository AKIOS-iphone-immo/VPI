//
//  Annonce.m
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Annonce.h"


@implementation Annonce

@synthesize /*idAnnonce,*/ref, nbPieces, surface, ville, cp, prix, descriptif, photos;

- (void) dealloc {
    [ref release];
	[nbPieces release];
	[surface release];
	[ville release];
	[cp release];
	[prix release];
	[descriptif release];
	[photos release];
	[super dealloc];
}

@end
