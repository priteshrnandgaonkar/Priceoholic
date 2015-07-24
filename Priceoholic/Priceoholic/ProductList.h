//
//  ProductList.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Filter.h"

@interface ProductList : NSObject
//@property (strong, nonatomic) NSNumber *maxCostFilter;
//@property (strong, nonatomic) NSArray *selectedShops;
@property (strong, nonatomic) Filter *filter;

+ (ProductList *) theProductList;
- (void)fetchProductsWithName:(NSString *)productName OnCompletion:(void (^)(NSArray *prioductList,NSError *error))completion;

@end
