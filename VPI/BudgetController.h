//
//  BudgetController.h
//  VPI
//
//  Created by Christophe Bergé on 23/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BudgetController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSMutableArray *arrayBudget;
    NSString *budget;
    UIPickerView *budgetPv;
}

@property(nonatomic,assign) NSString *budget;

@end
