//
//  Filter.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 22/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property (strong, nonatomic) NSArray *shopNames;
@property (strong, nonatomic) NSNumber *maxCost;
@property (nonatomic) BOOL isFilterAdded;

@end
