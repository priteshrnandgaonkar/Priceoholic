//
//  FilterViewController.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 21/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filter.h"

@protocol AppliedFilter <NSObject>

- (void) filterAppliedMethod:(Filter *)selectedShopNames;

@end

@interface FilterViewController : UIViewController

@property (weak, nonatomic) id <AppliedFilter> delegate;

@end
