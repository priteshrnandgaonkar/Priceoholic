//
//  ProductList.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "ProductList.h"
#import "Product.h"

@implementation ProductList

+ (ProductList *)theProductList {
    static ProductList *theProductList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theProductList = [[self alloc] init];
    });
    return theProductList;
}

- (id)init{
    self = [super init];
    if(self) {
    }
    return self;
}

- (void)fetchProductsWithName:(NSString *)productName OnCompletion:(void (^)(NSArray *prioductList, NSError *error))completion {
    
    productName = [productName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"http://api.pricecheckindia.com/feed/product/mobile_phones/%@.json?user=ankitspd&key=LRMANJYMMUHHKNHX",productName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!data){
                NSError *error = [NSError errorWithDomain:@"PRODUCT SEARCH DOMAIN" code:404 userInfo:@{NSLocalizedDescriptionKey : @"No data for this product"}];
                completion(nil, error);
                return;
            }
            NSError *error;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //NSArray *results = [MTLJSONAdapter modelsOfClass:Product.class fromJSONArray:responseDict[@"product"] error:&error];
            NSArray *listOfProductsQueried = responseDict[@"product"];
            if(listOfProductsQueried.count > 0){
                NSArray *productArray= [MTLJSONAdapter modelsOfClass:Product.class fromJSONArray:responseDict[@"product"] error:&error];
                NSLog(@"%@",@"success");
                completion(productArray, nil);
            
            } else {
                NSError *error = [NSError errorWithDomain:@"PRODUCT SEARCH DOMAIN" code:404 userInfo:@{NSLocalizedDescriptionKey : @"No data for this product"}];
                completion(nil, error);
                 NSLog(@"%@",error);
            }
        });
    }];

}


@end
