//
//  Product.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface Product : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSArray *stores;

@end
