//
//  Product.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "Product.h"
#import "Store.h"

@implementation Product

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"model": @"model",
             @"brand": @"brand",
             @"stores": @"stores"
             };
}

+ (NSValueTransformer *)storesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Store.class];
}

@end
