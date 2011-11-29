//
//  AfficheAnnonceController2.m
//  ParisDemeures
//
//  Created by Christophe Bergé on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AfficheAnnonceController2.h"


@implementation AfficheAnnonceController2

- (void)diapoControllerDidFinish:(DiapoController3 *)controller
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
    [imagesArray release];
	[arrayWithIndex release];
	[lAnnonce release];
    //[myOpenFlowView release];
    //myOpenFlowView = nil;
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
    arrayWithIndex = [[ArrayWithIndex alloc] init];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheAnnonce:) name:@"afficheAnnonce" object: nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheDiaporamaReady:) name:@"afficheDiaporamaReady" object: nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(coverFlowFicheDetaillee:) name:@"coverFlowFicheDetaillee" object: nil];
    
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonceReady" object: @"afficheAnnonceReady"];
    
    /*UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];*/
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [enTete setFrame:CGRectMake(70,0,240,80)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 3;
    
    [boutonRetour setFrame:CGRectMake(10,7,50,30)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    //[boutonRetour setTitle:@"Retour" forState:UIControlStateNormal];
    //boutonRetour.titleLabel.textColor = [UIColor blueColor];
    UIImage *image = [UIImage imageNamed:@"bouton-retour2.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    /*--- PREMIERE PHOTO ---*/
    NSString *string = [lAnnonce valueForKey:@"photos"];
	NSLog(@"PREMIERE PHOTO: %@", string);
    
    if ([string length] > 0) {
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		imagesArray = [[NSMutableArray alloc] initWithArray:[string componentsSeparatedByString:@";"]];
		[imagesArray removeLastObject];
        
		arrayWithIndex.array = imagesArray;
    }
    
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                         [NSURL URLWithString:[imagesArray objectAtIndex:0]]];
    
    UIImage *photo = [[UIImage alloc] initWithData:imageData];
    
    UIImageView *premierePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(5, 80, 110, 85)];
    [premierePhoto setImage:photo];
    
    [imageData release];
    [photo release];
    
    [self.view addSubview:premierePhoto];
    [premierePhoto release];
    /*--- PREMIERE PHOTO ---*/
    
    /*--- BANDEAU VIERGE ---*/
    /*UIImageView *vierge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-vierge.png"]];
    [vierge setFrame:CGRectMake(0,50,320,20)];
    [self.view addSubview:vierge];
    [vierge release];*/
    /*--- BANDEAU VIERGE ---*/
    
    /*--- CRITERES DANS LE BANDEAU ---*/
    /*UIScrollView *textScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 20)];
    textScroll.contentSize = CGSizeMake(640, 20);
    textScroll.userInteractionEnabled = YES;
    textScroll.scrollsToTop = YES;*/
    
    UITextView *criteresTextView = [[UITextView alloc] initWithFrame:CGRectMake(130, 70, 200, 110)];
    criteresTextView.text = @"";
    criteresTextView.backgroundColor = [UIColor clearColor];
    criteresTextView.editable = NO;
    
    NSString *text = @"";
    NSString *isS = @"";
    NSString *nbPieces = [lAnnonce valueForKey:@"nbPieces"];
    nbPieces = [nbPieces stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if ([nbPieces intValue] > 1) {
        isS = @"s";
    }
    
    NSString *prix = [lAnnonce valueForKey:@"prix"];
    
    /*NSNumber *formattedResult;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setGroupingSeparator:@" "];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    formattedResult = [NSNumber numberWithInt:[prix intValue]];
    prix = [formatter stringForObjectValue:formattedResult];
    
    [formatter release];*/
    
    text = [NSString stringWithFormat:@"%@€ - %@ piece%@- %@m² - %@",
            prix,
            nbPieces,
            isS,
            [lAnnonce valueForKey:@"surface"],
            [lAnnonce valueForKey:@"ville"]//,
            //[lAnnonce valueForKey:@"ref"]
            ];
    
    criteresTextView.text = text;
    
    //[textScroll addSubview:criteresTextView];
    //[self.view addSubview:textScroll];
    [self.view addSubview:criteresTextView];
    
    [criteresTextView release];
    //[textScroll release];
    
    /*--- CRITERES DANS LE BANDEAU ---*/
    /*--- COVER FLOW ---*/
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Fiche détaillée"];
    
    /*myOpenFlowView = [[AFOpenFlowViewDiapo alloc] init];
    [myOpenFlowView setFrame:CGRectMake(10, 75, 300, 130)];
    
    NSString *string = [lAnnonce valueForKey:@"photos"];
	
    if ([string length] > 0) {
		imagesArray = [[NSMutableArray alloc] initWithArray:[string componentsSeparatedByString:@","]];
		
		arrayWithIndex.array = imagesArray;
    }
    
    [myOpenFlowView setNumberOfImages:[imagesArray count]];
    
	for (int index = 0; index < [imagesArray count]; index++){
		NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                             [NSURL URLWithString:
                              [NSString stringWithFormat:@"%@",
                               [imagesArray objectAtIndex:index]]]];
        if (imageData != nil) {
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            [myOpenFlowView setImage:image forIndex:index];
        }
        [imageData release];
        
	}
    
    [self.view addSubview:myOpenFlowView];*/
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Fiche détaillée"];
    
    /*--- COVER FLOW ---*/
    
    /*--- BOUTON MAIL ---*/
    UIButton *boutonMail = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonMail.showsTouchWhenHighlighted = NO;
    boutonMail.tag = 2;
    
    [boutonMail setFrame:CGRectMake(100,170,100,30)];
    [boutonMail addTarget:self action:@selector(buttonEcrivez:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"BoutonMail.png"];
     [boutonMail setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonMail];
    /*--- BOUTON MAIL ---*/
    
    /*---PHOTOS ---*/
    //BANDEAU
    UIImageView *nbPhotos = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BarreNombreDePhoto.png"]];
    [nbPhotos setFrame:CGRectMake(0,205,320,20)];
    [self.view addSubview:nbPhotos];
    [nbPhotos release];
    
    //PHOTOS
    UIScrollView *photosScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 226, 320, 50)];
    photosScroll.scrollEnabled = YES;
    photosScroll.showsHorizontalScrollIndicator = YES;
    photosScroll.userInteractionEnabled = YES;
    photosScroll.contentSize = CGSizeMake([imagesArray count] * 77, 50);
    
    int i = 0;
    
    for (NSString *photoName in imagesArray) {
        UIButton *bouton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bouton setFrame:CGRectMake((i * 75) + 2, 0, 70, 40)];
        [bouton addTarget:self action:@selector(buttonImagePushed:) 
         forControlEvents:UIControlEventTouchUpInside];
        
        bouton.tag = i;
        
        NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                             [NSURL URLWithString:photoName]];
        
        UIImage *photo = [[UIImage alloc] initWithData:imageData];
        
        [bouton setImage:photo forState:UIControlStateNormal];
        [photosScroll addSubview:bouton];
        i++;
        [imageData release];
        [photo release];
    }
    [self.view addSubview:photosScroll];
    
    /*--- PHOTOS ---*/
    
    /*--- DESCRIPTION ---*/
    //BANDEAU
    UIImageView *description = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BarreDescription.png"]];
    [description setFrame:CGRectMake(0,270,320,20)];
    [self.view addSubview:description];
    [description release];
    
    //TEXTE
    UITextView *descriptif = [[UITextView alloc] initWithFrame:CGRectMake(0, 292, 320, 70)];
    descriptif.text = [lAnnonce valueForKey:@"descriptif"];
    descriptif.backgroundColor = [UIColor clearColor];
    descriptif.editable = NO;
    [self.view addSubview:descriptif];
    [descriptif release];
    /*--- DESCRIPTION ---*/
    
    /*--- CONTACT ---*/
    //BANDEAU
    UIImageView *contact = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BarreContactezNous.png"]];
    [contact setFrame:CGRectMake(0,372,320,20)];
    [self.view addSubview:contact];
    [contact release];
    
    //TEL
    UITextView *tel = [[UITextView alloc] initWithFrame:CGRectMake(15, 395, 150, 20)];
    tel.text = @"Tél : 01 39 87 67 43";
    tel.userInteractionEnabled = NO;
    tel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tel];
    [tel release];
    
    //FAX
    UITextView *fax = [[UITextView alloc] initWithFrame:CGRectMake(180, 395, 150, 20)];
    fax.text = @"Fax : 01 39 87 34 29";
    fax.userInteractionEnabled = NO;
    fax.backgroundColor = [UIColor clearColor];
    [self.view addSubview:fax];
    [fax release];
    
    //BOUTON ECRIVEZ NOUS
    /*UIButton *ecrivez = [UIButton buttonWithType:UIButtonTypeCustom];
    [ecrivez setFrame:CGRectMake(5, 340, 95, 65)];
    [ecrivez setImage:[UIImage imageNamed:@"ecrivez-nous.png"] forState:UIControlStateNormal];
    [ecrivez addTarget:self action:@selector(buttonEcrivez:) 
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ecrivez];
    
    //BOUTON APPELEZ NOUS
    UIButton *appelez = [UIButton buttonWithType:UIButtonTypeCustom];
    [appelez setFrame:CGRectMake(110, 340, 95, 65)];
    [appelez setImage:[UIImage imageNamed:@"appelez-nous.png"] forState:UIControlStateNormal];
    [appelez addTarget:self action:@selector(buttonAppelez:) 
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appelez];
    
    //ENVOYEZ AMI
    UIButton *envoyez = [UIButton buttonWithType:UIButtonTypeCustom];
    [envoyez setFrame:CGRectMake(215, 340, 95, 65)];
    [envoyez setImage:[UIImage imageNamed:@"envoyez-a-un-ami.png"] forState:UIControlStateNormal];
    [envoyez addTarget:self action:@selector(buttonEnvoyez:) 
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:envoyez];*/
    /*--- CONTACT ---*/
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Fiche détaillée"];
}

- (void) afficheDiaporamaReady:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheDiaporama" object: arrayWithIndex];
}

/*- (void) coverFlowFicheDetaillee:(NSNotification *)notify {
	NSNumber *num = [notify object];
    arrayWithIndex.arrayIndex = [num intValue];
    arrayWithIndex.titre = [NSString stringWithString:[lAnnonce valueForKey:@"ref"]];
    
    DiapoController3 *diaporamaController = [[DiapoController3 alloc] init];
    diaporamaController.delegate = self;
    diaporamaController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:diaporamaController animated:YES];
    //[self.navigationController pushViewController:diaporamaController animated:YES];
    [diaporamaController release];
}*/

- (void) afficheAnnonce:(NSNotification *)notify {
	lAnnonce = [[Annonce alloc] init];
	lAnnonce = [notify object];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Fiche détaillée"];
	//NSLog(@"%@",lAnnonce);
    
}

- (void) buttonPushed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonImagePushed:(id)sender
{
    UIButton *button = sender;
    arrayWithIndex.arrayIndex = button.tag;
    arrayWithIndex.titre = [NSString stringWithString:[lAnnonce valueForKey:@"ref"]];
    
    DiapoController3 *diaporamaController = [[DiapoController3 alloc] init];
    diaporamaController.delegate = self;
    diaporamaController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:diaporamaController animated:YES];
    //[self.navigationController pushViewController:diaporamaController animated:YES];
    [diaporamaController release];
}

- (void) buttonEcrivez:(id)sender
{
    NSLog(@"Mail à l'agence...");
    NSString *htmlBody = [NSString stringWithFormat:
                          @"Bonjour, <br>Je souhaite recevoir plus d'informations concernant le bien n°%@.</br> Merci.",
                          [lAnnonce valueForKey:@"ref"]]; 
    
    NSString *escapedBody = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
    
    NSString *mailtoPrefix = [[NSString stringWithString:@"mailto:contact@votreprojetimmo.com?subject=Demande d'informations&body="
                               ] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
    
    NSString *mailtoStr = [mailtoPrefix stringByAppendingString:escapedBody];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr]];
}

- (void) buttonAppelez:(id)sender
{
    NSLog(@"Phone...");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://+33156434141"]];
}

- (void) buttonEnvoyez:(id)sender
{
    //ENVOIE UN MAIL SANS DESTINATAIRE
    NSLog(@"Mail à un ami...");
    NSString *htmlBody = [NSString stringWithFormat:
                          @"Plus d'infos sur http://paris-demeures.com, r&eacute;f&eacute;rence: %@",
                          [lAnnonce valueForKey:@"ref"]]; 
    
    NSString *escapedBody = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
    
    NSString *mailtoPrefix = [@"mailto:?subject=Un ami vous recommande un bien&body=" stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
    
    NSString *mailtoStr = [mailtoPrefix stringByAppendingString:escapedBody];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr]];
    
    //TODO:
    //PARTAGE FACEBOOK ETC.
    //NSLog(@"Partage Facebook...");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    if ([UIApplication sharedApplication].networkActivityIndicatorVisible == YES) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    //[myOpenFlowView centerOnSelectedCover:YES];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Fiche détaillée"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
