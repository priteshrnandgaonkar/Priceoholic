//
//  CustomCollectionViewCell.h
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 17/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *productModelUILabelCell;
@property (weak, nonatomic) IBOutlet UILabel *productStoreUILabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *productPriceUILabelCell;

@end
