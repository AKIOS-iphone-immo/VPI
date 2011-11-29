//
//  Recherche.m
//  ParisDemeures
//
//  Created by Christophe Bergé on 16/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Recherche.h"


@implementation Recherche

@synthesize tableauAnnonces1, critere, critereWeb;

- (void)viewDidLoad {
    /*--- STOCKAGE DES ANNONCES ET CRITERES DE RECHERCHE ---*/
	critere = @"";
    critereWeb = [[NSMutableDictionary alloc] init];
    
	tableauAnnonces1 = [[NSMutableArray alloc] init];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(citiesSelected:) name:@"citiesSelected" object: nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(citySelected:) name:@"citySelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(typesSelected:) name:@"typesSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(surfaceSelected:) name:@"surfaceSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(nbPiecesSelected:) name:@"nbPiecesSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(budgetSelected:) name:@"budgetSelected" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheListeAnnoncesReady:) name:@"afficheListeAnnoncesReady" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(rechercheSauvee:) name:@"rechercheSauvee" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(getCriteres:) name:@"getCriteres" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(venteLocationSelected:) name:@"venteLocationSelected" object: nil];
    
    isConnectionErrorPrinted = NO;
    
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    /*--- STOCKAGE DES ANNONCES ET CRITERES DE RECHERCHE ---*/
    
    /*--- INTERFACE GRAPHIQUE ---*/
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    //self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [enTete setFrame:CGRectMake(10,0,300,100)];
    [self.view addSubview:enTete];
    
    [enTete release];
    
    /*UIImageView *sousEnTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recherche-multi-bandeau-sous-header.png"]];
    [sousEnTete setFrame:CGRectMake(0,50,320,50)];
    [self.view addSubview:sousEnTete];*/
    
    /*--- BOUTONS ---*/
    int xPos = 10;
    int yPos = 120;
    int yDecalage = 32;
    int xSize = 300;
    int ySize = 30;
    
    //BOUTON VENTE/LOCATION
    UIButton *boutonVL = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonVL.tag = 0;
    boutonVL.showsTouchWhenHighlighted = NO;
    
    [boutonVL setFrame:CGRectMake(xPos,yPos,xSize,ySize)];
    [boutonVL addTarget:self action:@selector(buttonPushed:) 
          forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [self getImage:@"BoutonVenteLocation"];
	[boutonVL setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonVL];
    
    //BOUTON TYPE DE BIEN
    UIButton *boutonTypeBien = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonTypeBien.tag = 1;
    boutonTypeBien.showsTouchWhenHighlighted = NO;
    
    [boutonTypeBien setFrame:CGRectMake(xPos,yPos + yDecalage,xSize,ySize)];
    [boutonTypeBien addTarget:self action:@selector(buttonPushed:) 
             forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonTypeDeBien"];
	[boutonTypeBien setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonTypeBien];
    
    //BOUTON VILLE
    /*UIButton *boutonVille = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonVille.tag = 2;
    boutonVille.showsTouchWhenHighlighted = NO;
    
    [boutonVille setFrame:CGRectMake(xPos,yPos + (yDecalage * 2),xSize,ySize)];
    [boutonVille addTarget:self action:@selector(buttonPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonLocalisation"];
	[boutonVille setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonVille];*/
    
    //BOUTON BUDGET
    UIButton *boutonBudget = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonBudget.tag = 3;
    boutonBudget.showsTouchWhenHighlighted = NO;
    
    [boutonBudget setFrame:CGRectMake(xPos,yPos + (yDecalage * 2),xSize,ySize)];
    [boutonBudget addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonBudget"];
	[boutonBudget setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonBudget];
    
    //BOUTON SURFACE
    /*UIButton *boutonSurface = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonSurface.tag = 4;
    boutonSurface.showsTouchWhenHighlighted = NO;
    
    [boutonSurface setFrame:CGRectMake(xPos,yPos + (yDecalage * 3),xSize,ySize)];
    [boutonSurface addTarget:self action:@selector(buttonPushed:) 
             forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonSurface"];
	[boutonSurface setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonSurface];*/
    
    //BOUTON NB PIECE
    UIButton *boutonNbPiece = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonNbPiece.tag = 5;
    boutonNbPiece.showsTouchWhenHighlighted = NO;
    
    [boutonNbPiece setFrame:CGRectMake(xPos,yPos + (yDecalage * 3),xSize,ySize)];
    [boutonNbPiece addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonNombreDePiece"];
	[boutonNbPiece setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonNbPiece];
    
    //BOUTON TRI DES RESULTATS
    /*UIButton *boutonTri = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonTri.tag = 6;
    boutonTri.showsTouchWhenHighlighted = NO;
    
    [boutonTri setFrame:CGRectMake(xPos,yPos + (yDecalage * 5),xSize,ySize)];
    [boutonTri addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonOrdreTriDesResultat"];
	[boutonTri setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonTri];*/
    
    //BOUTON RECHERCHE
    UIButton *boutonRecherche = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRecherche.tag = 7;
    boutonRecherche.showsTouchWhenHighlighted = NO;
    
    [boutonRecherche setFrame:CGRectMake(70,yPos + (yDecalage * 5) + 10,180,50)];
    [boutonRecherche addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [self getImage:@"BoutonLancerLaRecherche"];
	[boutonRecherche setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRecherche];
    /*--- INTERFACE GRAPHIQUE ---*/
    
}

-(UIImage *) getImage:(NSString *)cheminImage{
	UIImage *image = [UIImage imageWithContentsOfFile:
					  [[NSBundle mainBundle] pathForResource:
					   cheminImage ofType:@"png"]];
	
	return image;
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
        case 0:
            NSLog(@"Vente/Location");
            VenteLocation *venteLocation = [[VenteLocation alloc] init];
            [self.navigationController pushViewController:venteLocation animated:YES];
            [venteLocation release];
            venteLocation = nil;
            break;
		case 1:
            NSLog(@"Type de bien");
            SelectionTypeBienController *selectionTypeBienController =
			[[SelectionTypeBienController alloc] initWithStyle:UITableViewStylePlain];
            selectionTypeBienController.title = @"Type de bien";
            [self.navigationController pushViewController:selectionTypeBienController animated:YES];
            [selectionTypeBienController release];
            selectionTypeBienController = nil;
			break;
		case 2:
            NSLog(@"Ville");
            ChoixVilleController2 *choixVille = [[ChoixVilleController2 alloc] init];
            [self.navigationController pushViewController:choixVille animated:YES];
            [choixVille release];
            choixVille = nil;
            break;
        case 3:
            NSLog(@"Budget");
            /*SelectionBudgetController *selectionBudgetController =
            [[SelectionBudgetController alloc] initWithNibName:@"SelectionBudgetController" bundle:nil];
            selectionBudgetController.title = @"Budget";
            [self.navigationController pushViewController:selectionBudgetController animated:YES];
            [selectionBudgetController release];
            selectionBudgetController = nil;*/
            BudgetController *budgetController = [[BudgetController alloc] init];
            [self.navigationController pushViewController:budgetController animated:YES];
            break;
        case 4:
            NSLog(@"Surface");
            SelectionSurfaceController *selectionSurfaceController =
            [[SelectionSurfaceController alloc] initWithNibName:@"SelectionSurfaceController" bundle:nil];
            selectionSurfaceController.title = @"Surface";
            [self.navigationController pushViewController:selectionSurfaceController animated:YES];
            [selectionSurfaceController release];
            selectionSurfaceController = nil;
            break;
        case 5:
            NSLog(@"Nombre de pieces");
            SelectionNbPiecesController *selectionNbPiecesController =
			[[SelectionNbPiecesController alloc] initWithNibName:@"SelectionNbPiecesController" bundle:nil];
            selectionNbPiecesController.title = @"Nombre de pieces";
            [self.navigationController pushViewController:selectionNbPiecesController animated:YES];
            [selectionNbPiecesController release];
            selectionNbPiecesController = nil;
            break;
        case 6:
            NSLog(@"Ordre de tri resultats");
            break;
        case 7:
            NSLog(@"Lancer la recherche");
            isConnectionErrorPrinted = NO;
            [tableauAnnonces1 removeAllObjects];
            [self makeRequest];
            break;
		default:
			break;
	}
}

- (void)makeRequest{
    NSString *bodyString = @"http://www.vpimmo.fr/iphone.php?critere=";
    NSLog(@"critereWeb requete: %@", critereWeb);
    
    bodyString = [bodyString stringByAppendingString:[critereWeb valueForKey:@"critere"]];
    bodyString = [bodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"bodyString:%@\n",bodyString);

    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];

    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"recherche multicriteres"] forKey:@"name"]];
    
    [networkQueue addOperation:request];

    [networkQueue go];
}

- (void) getCriteres:(NSNotification *)notify {
    NSLog(@"critere getCrit: %@",critere);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setCriteres" object: critere];
}

- (void) venteLocationSelected:(NSNotification *)notify {
    //NSLog(@"criteres1 venteLocation: %@",criteres1);
    NSString *locVente = [notify object];
    int num = 69;
    num = num + [locVente intValue];
    [critereWeb setValue:[NSString stringWithFormat:@"%d",num] forKey:@"critere"];
    critere = [NSString stringWithFormat:@"%d",[locVente intValue]];
    NSLog(@"critere venteLocation: %@",critereWeb);
}

- (void) rechercheSauvee:(NSNotification *)notify {
    //criteres1 = [notify object];
    NSLog(@"critere rechSauv: %@",critere);
}

/*- (void) citySelected:(NSNotification *)notify {
	NSMutableArray *array = [notify object];
    
    if ([array count] != 0) {
        
        [criteres1 setValue:[array objectAtIndex:0] forKey:@"ville1"];
        [criteres1 setValue:[array objectAtIndex:1] forKey:@"cp1"];
    
    }
	NSLog(@"criteres1: %@",criteres1);
}*/

- (void) typesSelected:(NSNotification *)notify {
	NSMutableArray *typesSelected = [notify object];
	
    NSIndexPath *indexPath = [typesSelected objectAtIndex:0];
    
	critere =  [NSString stringWithFormat:@"%d", indexPath.row];
    
    int num = 72;
    num = num + [critere intValue];
    [critereWeb setValue:[NSString stringWithFormat:@"%d", num] forKey:@"critere"];
    
    NSLog(@"critere: %@",critereWeb);
}
/*
- (void) surfaceSelected:(NSNotification *)notify {
	Intervalle *intervalle = [notify object];
	int min = [intervalle min];
	int max = [intervalle max];
	
	if ((min != 0) && (max != 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",min] forKey:@"surface_mini"];
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",max] forKey:@"surface_maxi"];
	}
    
    if ((min != 0) && (max == 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",min] forKey:@"surface_mini"];
	}
    
    if ((min == 0) && (max != 0)) {
		[criteres1 setValue:[@"" stringByAppendingFormat:@"%d",max] forKey:@"surface_maxi"];
	}
    NSLog(@"criteres1: %@",criteres1);
}
*/

- (void) nbPiecesSelected:(NSNotification *)notify {
    NSMutableArray *typesSelected = [notify object];
	
    NSIndexPath *indexPath = [typesSelected objectAtIndex:0];
    
	critere =  [NSString stringWithFormat:@"%d", indexPath.row];
    
    int num = 63;
    num = num + [critere intValue];
    [critereWeb setValue:[NSString stringWithFormat:@"%d", num] forKey:@"critere"];
    
    NSLog(@"critere: %@",critereWeb);
}


- (void) budgetSelected:(NSNotification *)notify {
    critere = [notify object];
    [critereWeb setValue:[notify object] forKey:@"critere"];
    NSLog(@"critere: %@",critereWeb);
}

- (void) afficheListeAnnoncesReady:(NSNotification *)notify {
    NSLog(@"COUCOU");
    NSLog(@"tableau Annonces: %@", tableauAnnonces1);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:critereWeb copyItems:NO];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:tableauAnnonces1 copyItems:NO];
    NSArray *criteresEtAnnonces = [NSArray arrayWithObjects:dict, array, nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheListeAnnonces" object: criteresEtAnnonces];
}

- (void)requestDone:(ASIHTTPRequest *)request
//- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
    
    NSLog(@"dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
    NSError *error = nil;
    
    if ([string length] > 0) {
        
        NSString *string2 = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
        NSData *dataString = [string2 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:dataString];
        
        NSLog(@"REPONSE DU WEB 2: \"%@\"\n",string2);
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens2" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);*/
         
        
        
        if ([string rangeOfString:@"<Biens></Biens>"].length != 0) {
            //AUCUNE ANNONCES
            NSDictionary *userInfo = [NSDictionary 
                                      dictionaryWithObject:@"Aucun bien ne correspond à ces critères dans notre base de données."
                                      forKey:NSLocalizedDescriptionKey];
            
            error =[NSError errorWithDomain:@"Aucun bien trouvé."
                                       code:1 userInfo:userInfo];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aucun bien trouvé"
                                                            message:[error localizedDescription]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else{
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            XMLParser *parser = [[XMLParser alloc] initXMLParser];
            
            [xmlParser setDelegate:parser];
            
            BOOL success = [xmlParser parse];
            
            if(success)
                NSLog(@"No Errors on XML parsing.");
            else
                NSLog(@"Error on XML parsing!!!");
            
            AfficheListeAnnoncesController2 *afficheListeAnnoncesController = 
            [[AfficheListeAnnoncesController2 alloc] init];
            afficheListeAnnoncesController.title = @"Annonces";
            [self.navigationController pushViewController:afficheListeAnnoncesController animated:YES];
            [afficheListeAnnoncesController release];
            
        }
        [data release];
        [string release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    
    if (!isConnectionErrorPrinted) {
        alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connection."
                                           message:[error localizedDescription]
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
        [alert release];
        isConnectionErrorPrinted = YES;
    }
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    //[criteres removeAllObjects];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [self.view release];
    [tableauAnnonces1 release];
	//[critere release];
    [critereWeb release];
    [networkQueue release];
    [super dealloc];
}


@end

