//
//  Agence.m
//  ParisDemeures
//
//  Created by Christophe Bergé on 14/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Agence.h"


@implementation Agence

- (void)geolocViewControllerDidFinish:(GeolocViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

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
    
    //COULEUR DE FOND
    /*UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];*/
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [enTete setFrame:CGRectMake(10,0,300,100)];
    [self.view addSubview:enTete];
    [enTete release];
    
    /*--- BOUTON ADRESSE ---*/
    /*UIButton *boutonAdresse = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonAdresse setFrame:CGRectMake(20, 102, 280, 70)];
	[boutonAdresse setUserInteractionEnabled:NO];
    
    UIImage *image = [UIImage imageNamed:@"Adresse3.png"];
	[boutonAdresse setImage:image forState:UIControlStateNormal];
    
    boutonAdresse.showsTouchWhenHighlighted = NO;
    boutonAdresse.tag = 0;
	
	[self.view addSubview:boutonAdresse];*/
    /*--- BOUTON ADRESSE ---*/
    /*--- BOUTON TELEPHONE ---*/
    UIButton *boutonTelephone = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonTelephone setFrame:CGRectMake(20, 178, 280, 60)];
	[boutonTelephone setUserInteractionEnabled:YES];
	[boutonTelephone addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"Telephone3.png"];
	[boutonTelephone setImage:image forState:UIControlStateNormal];
    
    boutonTelephone.showsTouchWhenHighlighted = NO;
    boutonTelephone.tag = 1;
	
	[self.view addSubview:boutonTelephone];
    /*--- BOUTON TELEPHONE ---*/
    /*--- BOUTON EMAIL ---*/
    UIButton *boutonEmail = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEmail setFrame:CGRectMake(20, 244, 280, 60)];
	[boutonEmail setUserInteractionEnabled:YES];
	[boutonEmail addTarget:self action:@selector(buttonPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"Email3.png"];
	[boutonEmail setImage:image forState:UIControlStateNormal];
    
    boutonEmail.showsTouchWhenHighlighted = NO;
    boutonEmail.tag = 2;
	
	[self.view addSubview:boutonEmail];
    /*--- BOUTON EMAIL ---*/
    /*--- BOUTON GEOLOC ---*/
    UIButton *boutonGeoloc = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonGeoloc setFrame:CGRectMake(20, 112, 280, 60)];
	[boutonGeoloc setUserInteractionEnabled:YES];
	[boutonGeoloc addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"BoutonLocalisezNous.png"];
	[boutonGeoloc setImage:image forState:UIControlStateNormal];
    
    boutonGeoloc.showsTouchWhenHighlighted = NO;
    boutonGeoloc.tag = 3;
	
	[self.view addSubview:boutonGeoloc];
    /*--- BOUTON GEOLOC ---*/
    /*--- BOUTON EMAIL RECOMMANDATION ---*/
    UIButton *boutonEmailR = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEmailR setFrame:CGRectMake(20, 310, 135, 70)];
	[boutonEmailR setUserInteractionEnabled:YES];
	[boutonEmailR addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"recommander.png"];
	[boutonEmailR setImage:image forState:UIControlStateNormal];
    
    boutonEmailR.showsTouchWhenHighlighted = NO;
    boutonEmailR.tag = 4;
	
	[self.view addSubview:boutonEmailR];
    /*--- BOUTON EMAIL RECOMMANDATION ---*/
    /*--- BOUTON SITE AKIOS ---*/
    UIButton *boutonSite = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonSite setFrame:CGRectMake(165, 310, 135, 70)];
	[boutonSite setUserInteractionEnabled:YES];
	[boutonSite addTarget:self action:@selector(buttonPushed:) 
         forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"site_akios.png"];
	[boutonSite setImage:image forState:UIControlStateNormal];
    
    boutonSite.showsTouchWhenHighlighted = NO;
    boutonSite.tag = 5;
	
	[self.view addSubview:boutonSite];
    /*--- BOUTON SITE AKIOS ---*/
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
		case 1:
            NSLog(@"tel.");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+33178840014"]];
            break;
        case 2:
            NSLog(@"email.");
            NSString *htmlBody = [NSString stringWithFormat:@""]; 
            
            NSString *escapedBody = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
            
            NSString *mailtoPrefix = [[NSString stringWithFormat:@"mailto:contact@votreprojetimmo.com?subject=Demande d'informations&body="] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            
            NSString *mailtoStr = [mailtoPrefix stringByAppendingString:escapedBody];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr]];
            break;
        case 3:
            NSLog(@"geoloc.");
            GeolocViewController *geoLoc = [[GeolocViewController alloc] init];
            geoLoc.delegate = self;
            geoLoc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:geoLoc animated:YES];
            [geoLoc release];
			break;
        case 4:
            NSLog(@"email recommandation.");
            NSString *htmlBody2 = [NSString stringWithFormat:@""]; 
            
            NSString *escapedBody2 = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody2, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
            
            NSString *mailtoPrefix2 = [[NSString stringWithFormat:@"mailto:?subject=Un ami vous recommande l'application VPI&body="] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            
            NSString *mailtoStr2 = [mailtoPrefix2 stringByAppendingString:escapedBody2];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr2]];
            break;
        case 5:
            NSLog(@"Site Akios");
            NSString *urlAkios = [[NSString stringWithFormat:@"http://www.akios.fr/"] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAkios]];
            break;
		default:
			break;
	}
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

@end
