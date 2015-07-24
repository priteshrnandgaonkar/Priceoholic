//
//  FilterViewController.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 21/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "FilterViewController.h"
#import "ProductList.h"
#import "Filter.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *maxCostUILabel;
@property (weak, nonatomic) IBOutlet UISlider *costSlider;
@property (weak, nonatomic) IBOutlet UIImageView *flipkartCheckBoxUIImage;
@property (weak, nonatomic) IBOutlet UIImageView *snapdealCheckBoxUIImage;
@property (weak, nonatomic) IBOutlet UIImageView *infibeamCheckBoxUIImage;
@property (weak, nonatomic) IBOutlet UIImageView *ebayCheckBoxUIImage;

@property (weak, nonatomic) IBOutlet UILabel *flipkartUILabel;
@property (weak, nonatomic) IBOutlet UILabel *snapdealUILabel;
@property (weak, nonatomic) IBOutlet UILabel *ebayUILabel;
@property (weak, nonatomic) IBOutlet UILabel *infibeamUILabel;

@property (weak, nonatomic) IBOutlet UIView *flipkartUIView;
@property (weak, nonatomic) IBOutlet UIView *snapdealUIView;
@property (weak, nonatomic) IBOutlet UIView *ebayUIView;
@property (weak, nonatomic) IBOutlet UIView *infibeamUIView;

@property (strong, nonatomic) NSNumber *maxCostSelected;
@property (nonatomic) BOOL isFlipkartSelected;
@property (nonatomic) BOOL isSnapdealSelected;
@property (nonatomic) BOOL isEbaySelected;
@property (nonatomic) BOOL isInfibeamSelected;
@property (strong, nonatomic) Filter *filter;

@end

static int  const  maxCost = 100000;

@implementation FilterViewController


#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(clickedOnApply)];
    [applyButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Helvetica-Bold" size:17.0], NSFontAttributeName,
                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = applyButton;
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(clickedOnReset)];
     [resetButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"Helvetica-Bold" size:17.0], NSFontAttributeName,
                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                          nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = resetButton;
    [self addGesturesToView];
    self.maxCostSelected = ProductListInstance.filter.maxCost;
    self.navigationItem.title = @"FILTERS";
    [self addExistingFilter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma Click Methods
- (IBAction)clickedOnApplyButton:(id)sender {
    [self clickedOnApply];
}

- (void)clickedOnReset{
    Filter *filterToBeStored = [[Filter alloc] init];
    self.maxCostSelected = [NSNumber numberWithFloat:0];
    filterToBeStored.maxCost = self.maxCostSelected;
    filterToBeStored.shopNames = [NSArray array];
    ProductListInstance.filter = filterToBeStored;
    [self addExistingFilter];
}

- (void)clickedOnApply{
    //ProductListInstance
    NSMutableArray *arrayShopSelected = [NSMutableArray array];
    if(self.isFlipkartSelected){
        [arrayShopSelected addObject:@"flipkart"];
    }
    if(self.isSnapdealSelected){
        [arrayShopSelected addObject:@"snapdeal"];
    }
    if(self.isEbaySelected){
        [arrayShopSelected addObject:@"ebay"];
    }
    if(self.isInfibeamSelected){
        [arrayShopSelected addObject:@"infibeam"];
    }
    Filter *filterToBeStored = [[Filter alloc] init];
    filterToBeStored.maxCost = self.maxCostSelected;
    filterToBeStored.shopNames = [arrayShopSelected copy];
    filterToBeStored.isFilterAdded = YES;
    ProductListInstance.filter = filterToBeStored;
    if([self.delegate respondsToSelector:@selector(filterAppliedMethod:)]){
        [self.delegate filterAppliedMethod:ProductListInstance.filter];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
   
}

- (void)clickedOnFlipkart{
    self.isFlipkartSelected = !self.isFlipkartSelected;
    if(!self.isFlipkartSelected){
        self.flipkartUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
        self.flipkartCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
        self.isFlipkartSelected = !self.isFlipkartSelected;
    }
    else{
        self.flipkartUILabel.textColor = [UIColor colorWithRed:0/255.00 green:0/255.0 blue:0/255.0 alpha:1];
        self.flipkartCheckBoxUIImage.image = [UIImage imageNamed:@"unchecked.png"];
    }
}

- (void)clickedOnSnapdeal{
    self.isSnapdealSelected = !self.isSnapdealSelected;
    if(!self.isSnapdealSelected){
        self.snapdealUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
        self.snapdealCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
    }else{
        self.snapdealUILabel.textColor = [UIColor colorWithRed:0/255.00 green:0/255.0 blue:0/255.0 alpha:1];
        self.snapdealCheckBoxUIImage.image = [UIImage imageNamed:@"unchecked.png"];
    }
}

- (void)clickedOnInfibeam{
    self.isInfibeamSelected = !self.isInfibeamSelected;
    if(!self.isInfibeamSelected){
        self.infibeamUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
        self.infibeamCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];

    }else{
        self.infibeamUILabel.textColor = [UIColor colorWithRed:0/255.00 green:0/255.0 blue:0/255.0 alpha:1];
        self.infibeamCheckBoxUIImage.image = [UIImage imageNamed:@"unchecked.png"];
    }
}

- (void)clickedOnEbay{
    self.isEbaySelected = !self.isEbaySelected;
    if(!self.isEbaySelected){
        self.ebayUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
        self.ebayCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
    }else{
        self.ebayUILabel.textColor = [UIColor colorWithRed:0/255.00 green:0/255.0 blue:0/255.0 alpha:1];
        self.ebayCheckBoxUIImage.image = [UIImage imageNamed:@"unchecked.png"];
    }
}
- (IBAction)sliderValueChanged:(id)sender {
    NSLog(@"Slider value %f",maxCost*self.costSlider.value);
    self.maxCostSelected = [NSNumber numberWithFloat:nearbyint(maxCost*self.costSlider.value)];
    self.maxCostUILabel.text = [NSString stringWithFormat:@"Rs. %d Max",(int)nearbyint(maxCost*self.costSlider.value)];
}

#pragma Utilities

- (void)addGesturesToView{
    self.isFlipkartSelected = NO;
    self.isSnapdealSelected = NO;
    self.isInfibeamSelected = NO;
    self.isEbaySelected = NO;
    UITapGestureRecognizer *tapperFlipkart = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnFlipkart)];
    UITapGestureRecognizer *tapperSnapdeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnSnapdeal)];
    UITapGestureRecognizer *tapperInfibeam = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnInfibeam)];
    UITapGestureRecognizer *tapperEbay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedOnEbay)];
    tapperFlipkart.numberOfTapsRequired = 1;
    tapperSnapdeal.numberOfTapsRequired = 1;
    tapperInfibeam.numberOfTapsRequired = 1;
    tapperEbay.numberOfTapsRequired = 1;
    [self.flipkartUIView addGestureRecognizer:tapperFlipkart];
    [self.snapdealUIView addGestureRecognizer:tapperSnapdeal];
    [self.infibeamUIView addGestureRecognizer:tapperInfibeam];
    [self.ebayUIView addGestureRecognizer:tapperEbay];
}

- (void)addExistingFilter{
    self.isFlipkartSelected = NO;
    self.isInfibeamSelected = NO;
    self.isSnapdealSelected = NO;
    self.isEbaySelected = NO;
    self.costSlider.value = [ProductListInstance.filter.maxCost floatValue]/maxCost;
    self.maxCostUILabel.text = [NSString stringWithFormat:@"Rs. %d Max",[self.maxCostSelected intValue]];
    NSArray *arrayFilterLabels = [NSArray arrayWithObjects:self.flipkartUILabel,self.snapdealUILabel,self.ebayUILabel,self.infibeamUILabel,nil];
     NSArray *arrayCheckBoxes = [NSArray arrayWithObjects:self.flipkartCheckBoxUIImage,self.snapdealCheckBoxUIImage,self.ebayCheckBoxUIImage,self.infibeamCheckBoxUIImage,nil];
    [self initialStateOfFilters:arrayFilterLabels withCheckBoxes:arrayCheckBoxes];
    for(int j = 0; j < ProductListInstance.filter.shopNames.count; ++j){
        if([[ProductListInstance.filter.shopNames objectAtIndex:j] isEqualToString:@"flipkart"]){
            self.isFlipkartSelected =YES;
            self.flipkartUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
            self.flipkartCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
        }
        if([[ProductListInstance.filter.shopNames objectAtIndex:j] isEqualToString:@"ebay"]){
            self.isEbaySelected =YES;
            self.ebayUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
            self.ebayCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
        }
        if([[ProductListInstance.filter.shopNames objectAtIndex:j] isEqualToString:@"infibeam"]){
            self.isInfibeamSelected =YES;
            self.infibeamUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
            self.infibeamCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
        }
        if([[ProductListInstance.filter.shopNames objectAtIndex:j] isEqualToString:@"snapdeal"]){
            self.isSnapdealSelected =YES;
            self.snapdealUILabel.textColor = [UIColor colorWithRed:249.0/255.00 green:94.0/255.0 blue:102.0/255.0 alpha:1];
            self.snapdealCheckBoxUIImage.image = [UIImage imageNamed:@"checked.png"];
        }
    }

}

- (void) initialStateOfFilters:(NSArray *) arrayLabel withCheckBoxes:(NSArray *) arrayCheckBox{
    
    for(int j = 0; j<arrayLabel.count ; ++j){
        UILabel *label = [arrayLabel objectAtIndex:j];
        UIImageView *imageView = [arrayCheckBox objectAtIndex:j];
        label.textColor = [UIColor colorWithRed:0/255.00 green:0/255.0 blue:0/255.0 alpha:1];
        imageView .image = [UIImage imageNamed:@"unchecked.png"];
    }
    
}


@end
