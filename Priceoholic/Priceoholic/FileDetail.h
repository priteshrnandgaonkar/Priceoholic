//
//  FileDetail.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 23/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDetail : NSObject

@property (nonatomic) BOOL isFlipkartSelected;
@property (nonatomic) BOOL isSnapdealSelected;
@property (nonatomic) BOOL isInfibeamSelected;
@property (nonatomic) BOOL isEbaySelected;
@property (strong, nonatomic) NSNumber *maxCountSelected;

@end
