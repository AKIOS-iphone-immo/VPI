//
//  BudgetController.m
//  VPI
//
//  Created by Christophe Bergé on 23/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BudgetController.h"


@implementation BudgetController

@synthesize budget;

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
    [budgetPv release];
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
    budget = @"";
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 0;
    
    [boutonRetour setFrame:CGRectMake(20,50,50,30)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    //[boutonRetour setTitle:@"Retour" forState:UIControlStateNormal];
    //boutonRetour.titleLabel.textColor = [UIColor blueColor];
    UIImage *image = [UIImage imageNamed:@"bouton-retour2.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    //PICKER VIEW
    budgetPv = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 100, 50)];
    //[budgetPv release];
    
    arrayBudget = [[NSMutableArray alloc] init];
    [arrayBudget addObject:@"  100 000 € à 150 000 €"];
    [arrayBudget addObject:@"  150 000 € à 200 000 €"];
    [arrayBudget addObject:@"  200 000 € à 250 000 €"];
    [arrayBudget addObject:@"  250 000 € à 300 000 €"];
    [arrayBudget addObject:@"  300 000 € à 400 000 €"];
    [arrayBudget addObject:@"  400 000 € à 500 000 €"];
    [arrayBudget addObject:@"  500 000 € et plus"];
    [arrayBudget addObject:@"  Moins de 100 000 €"];
    
    budgetPv.showsSelectionIndicator = YES;
    budgetPv.delegate = self;
    budgetPv.dataSource = self;
    
    [budgetPv selectRow:1 inComponent:0 animated:NO];
    
    [self.view addSubview:budgetPv];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    budget = [NSString stringWithFormat:@"%d", [budgetPv selectedRowInComponent:0] + 52];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"budgetSelected" object:budget];
    [super viewWillDisappear:animated];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

/*- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //mlabel.text=    [arrayBudget objectAtIndex:row];
    //budget = [NSString stringWithFormat:@"%d",row + 52];
    budget = @"";
    budget = [budget stringByAppendingFormat:@"%d",row + 52];
    NSLog(@"budget: %@",budget);
}*/

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayBudget count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayBudget objectAtIndex:row];
}


@end
