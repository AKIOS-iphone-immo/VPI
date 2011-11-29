//
//  VenteLocation.m
//  VPI
//
//  Created by Christophe Bergé on 04/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VenteLocation.h"


@implementation VenteLocation

@synthesize venteLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [venteLocation release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    venteLocation = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Locations", @"Ventes", nil]];
    [venteLocation setFrame:CGRectMake(60, 100, 200, 50)];
    venteLocation.segmentedControlStyle = UISegmentedControlStyleBar;
    venteLocation.selectedSegmentIndex = 0;
    //venteLocation.tintColor = [UIColor greenColor];
    [self.view addSubview:venteLocation];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 0;
    
    [boutonRetour setFrame:CGRectMake(20,200,50,30)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    //[boutonRetour setTitle:@"Retour" forState:UIControlStateNormal];
    //boutonRetour.titleLabel.textColor = [UIColor blueColor];
    UIImage *image = [UIImage imageNamed:@"bouton-retour2.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    
	switch (button.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
		default:
			break;
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"venteLocationSelected" object:[NSString stringWithFormat:@"%d", venteLocation.selectedSegmentIndex]];
    [super viewWillDisappear:animated];
}

@end
