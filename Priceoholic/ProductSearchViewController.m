//
//  ProductSearchViewController.m
//  Priceoholic
//
//  Created by Pritesh Nandgaonkar on 16/07/15.
//  Copyright (c) 2015 Pritesh Nandgaonkar. All rights reserved.
//

#import "ProductSearchViewController.h"
#import "ProductList.h"
#import "Product.h"
#import "CollectionViewController.h"

@interface ProductSearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintSearchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchProductTextField;
@property (assign, nonatomic) BOOL isKeyboardOpen;
@property (nonatomic, strong) NSArray *productsArray;

@end

@implementation ProductSearchViewController

#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isKeyboardOpen = NO;
    [self registerForKeyboardNotifications];
   
    
}
- (void)viewWillAppear:(BOOL)animated{
     //ProductListInstance.selectedShops = [NSArray array];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


/*- (void)networkCall {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.pricecheckindia.com/feed/product/mobile_phones/nexus+5.json?user=ankitspd&key=LRMANJYMMUHHKNHX"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError *error;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *results = [MTLJSONAdapter modelsOfClass:Product.class fromJSONArray:responseDict[@"product"] error:&error];
            NSLog(@"%@",[[results objectAtIndex:0] brand]);
            
            
        });
    }];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)searchProductPrices:(id)sender {
   // ProductListInstance.productSearched = self.searchProductTextField.text;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    [ProductListInstance fetchProductsWithName:self.searchProductTextField.text OnCompletion:^(NSArray *productList, NSError *error) {
        if(error) {
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            [self showAlertView:error.localizedDescription];
            return;
        }
        self.productsArray = productList;
        NSLog(@"%@",[[productList objectAtIndex:0] stores]);
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [self trasitionToCollectionView];
    }];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)handleKeyboardWillChangeFrameNotification:(NSNotification*)aNotification {
    
    NSDictionary *info = [aNotification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
   if(!self.isKeyboardOpen) {
        self.bottomConstraintSearchButton.constant =  kbSize.height;
    }else {
        self.bottomConstraintSearchButton.constant =  0;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    self.isKeyboardOpen = !self.isKeyboardOpen;
    if(!self.isKeyboardOpen){
        [self.searchProductTextField resignFirstResponder];
    }
}

#pragma mark - UITextFieldDelegates

- (void)textFieldDidBeginEditing:(id)iTextField {
    [iTextField selectAll:self];
}

#pragma mark - Utilites

- (void)showAlertView:(NSString *)errorMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message:errorMessage delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"productCollectionView"]) {
        [segue.destinationViewController setProducts:self.productsArray];
        [segue.destinationViewController setProductSearched:self.searchProductTextField.text];
    }
}

- (void)trasitionToCollectionView {
    [self performSegueWithIdentifier:@"productCollectionView" sender:self];
}

@end
