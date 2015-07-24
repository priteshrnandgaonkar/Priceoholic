//
//  Store.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mantle.h"

@interface Store : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) Product *storeProduct;
@property (strong, nonatomic) UIImage *thumb;

@end
