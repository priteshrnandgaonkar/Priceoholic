//
//  CollectionViewController.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 17/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "ProductList.h"
#import "CollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "Filter.h"

@interface CollectionViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *numOfProductsLabel;

@property (strong,nonatomic) NSMutableArray *arrayOfStores;
@property (strong,nonatomic) NSMutableArray *unchangeableArrayOfStores;
@property (nonatomic) BOOL returnedFromFilter;

- (void)clickedOnFilter;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"collectionCell";

#pragma mark view methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfStores = [NSMutableArray array];
    self.unchangeableArrayOfStores = [NSMutableArray array];
    self.returnedFromFilter = NO;
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(clickedOnFilter)];
    [anotherButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Helvetica-Bold" size:17.0], NSFontAttributeName,
                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = anotherButton;
    NSLog(@"%lu", self.products.count);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.returnedFromFilter){
        [self initializeArrays:self.products];
        [self filterAppliedMethod:ProductListInstance.filter];
    }
    self.numOfProductsLabel.text = [NSString stringWithFormat:@"%i products found for %@", (int)self.arrayOfStores.count, self.productSearched];
    self.navigationItem.title = self.productSearched;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:1.0]};
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:249.0/255.0 green:94.0/255.0 blue:102.0/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfStores.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Store *store = [self.arrayOfStores objectAtIndex:indexPath.row];
    cell.productModelUILabelCell.text = store.storeProduct.model;
    cell.productPriceUILabelCell.text = [NSString stringWithFormat:@"Rs.%@", store.price.stringValue];
    cell.productStoreUILabel.text = store.website;
    cell.productImageViewCell.image = nil;
    if(!store.thumb) {
        [self downloadImageWithStore:store completionBlock:^(BOOL succeeded, Store *downloadBlockStore, NSData *imageData) {
            if (succeeded) {
                if(store == downloadBlockStore){
                    cell.productImageViewCell.image = [UIImage imageWithData:imageData];
                    store.thumb = [UIImage imageWithData:imageData];
                }
            }
        }];
    }
    else {
        cell.productImageViewCell.image = store.thumb;
    }
    return cell;
}

- (void) clickedOnFilter{
    [self performSegueWithIdentifier:@"filterPage" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [[segue destinationViewController] setDelegate:self];
}

#pragma mark Utilities

- (NSInteger)numOfProductsMethod:(NSArray *) productsArray{
        return [self.unchangeableArrayOfStores count];
}
- (void)downloadImageWithStore:(Store *)store completionBlock:(void (^)(BOOL succeeded, Store *store, NSData *data))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:store.imageURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            completionBlock(YES, store, data);
        } else {
            completionBlock(NO, store, nil);
        }
    }];
}
- (void) filterAppliedMethod:(Filter *)selectedFilter{
    self.returnedFromFilter = YES;

    if(selectedFilter.shopNames.count == 0 && [selectedFilter.maxCost intValue] > 0){
        self.arrayOfStores = [NSMutableArray array];
        for(int i = 0; i< self.unchangeableArrayOfStores.count; ++i){
                if([selectedFilter.maxCost intValue] > [[[self.unchangeableArrayOfStores objectAtIndex:i] price] intValue]){
                    [self.arrayOfStores addObject:[self.unchangeableArrayOfStores objectAtIndex:i]];
                }
        }
    }
    else if (selectedFilter.shopNames.count > 0 && [selectedFilter.maxCost intValue] == 0){
        self.arrayOfStores = [NSMutableArray array];
        for(int i = 0; i< self.unchangeableArrayOfStores.count; ++i){
            for(int j = 0 ;j<selectedFilter.shopNames.count; ++j){
                if([[selectedFilter.shopNames objectAtIndex:j] isEqualToString:[[self.unchangeableArrayOfStores objectAtIndex:i] website]]){
                    [self.arrayOfStores addObject:[self.unchangeableArrayOfStores objectAtIndex:i]];
                    break;
                }
            }
        }
    }
    else if(selectedFilter.shopNames.count == 0 && [selectedFilter.maxCost intValue] == 0){
        self.arrayOfStores = [self.unchangeableArrayOfStores mutableCopy];
    }
    else{
        self.arrayOfStores = [NSMutableArray array];
        for(int i = 0; i< self.unchangeableArrayOfStores.count; ++i){
            for(int j = 0 ;j<selectedFilter.shopNames.count; ++j){
                if([[selectedFilter.shopNames objectAtIndex:j] isEqualToString:[[self.unchangeableArrayOfStores objectAtIndex:i] website]] && [selectedFilter.maxCost intValue] > [[[self.unchangeableArrayOfStores objectAtIndex:i] price] intValue]){
                    [self.arrayOfStores addObject:[self.unchangeableArrayOfStores objectAtIndex:i]];
                    break;
                }
            }
        }
    }
    [self.collectionView reloadData];

}

- (void)initializeArrays:(NSArray *) productsArray{
    self.arrayOfStores = [NSMutableArray array];
    self.unchangeableArrayOfStores = [NSMutableArray array];
        for(int j=0;j<productsArray.count;++j){
            for(int k=0;k<[[productsArray objectAtIndex:j] stores].count;++k){
                Store *storeProduct = [[Store alloc] init];
                storeProduct.website = [[[[productsArray objectAtIndex:j] stores] objectAtIndex:k] website];
                storeProduct.price = [[[[productsArray objectAtIndex:j] stores] objectAtIndex:k] price];
                storeProduct.storeProduct = [productsArray objectAtIndex:j];
                storeProduct.imageURL = [[[[productsArray objectAtIndex:j] stores] objectAtIndex:k] imageURL];
                [self.arrayOfStores addObject:storeProduct];
                [self.unchangeableArrayOfStores addObject:storeProduct];
            }
        }
}


@end
