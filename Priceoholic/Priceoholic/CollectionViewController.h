//
//  CollectionViewController.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 17/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"

@interface CollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, AppliedFilter>

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSString *productSearched;

@end
