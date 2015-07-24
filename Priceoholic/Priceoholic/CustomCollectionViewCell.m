//
//  CustomCollectionViewCell.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 17/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.layer.shadowOpacity = 0.3f;
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.layer.masksToBounds = NO;
}

@end
