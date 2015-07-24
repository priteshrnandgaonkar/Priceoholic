//
//  Store.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "Store.h"

@implementation Store

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"website": @"website",
             @"price": @"price",
             @"imageURL": @"image"
             };
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *url, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:url];
    }];
}
+ (NSValueTransformer *)priceJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *priceString, BOOL *success, NSError *__autoreleasing *error) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        return [f numberFromString:priceString];
    }];
}


@end
