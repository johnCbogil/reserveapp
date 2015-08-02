//
//  ViewController.m
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "ViewController.h"
#import "LocationService.h"
#import "NetworkManager.h"
#import "FoodManager.h"
#import "FoodItem.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()
@property (nonatomic, strong) UIAlertController *alertController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSortByActionSheet];
    self.title = @"Free Food Near You";
    //[[LocationService sharedInstance]startUpdatingLocation];
    [[FoodManager sharedInstance]createFoodItemWithCompletion:^{
        [self.tableView reloadData];
    } onError:^(NSError *error) {
        
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSortByActionSheet{
    self.alertController = [UIAlertController
                            alertControllerWithTitle:@":)"
                            message:@"Sorty by"
                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    UIAlertAction *distanceAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Distance", @"Distance action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"distance action");
                                   }];
    UIAlertAction *abcAction = [UIAlertAction
                                     actionWithTitle:NSLocalizedString(@"Alphabetical", @"abc action")
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action)
                                     {
                                         NSLog(@"abc action");
                                         
                                         NSSortDescriptor *sortParam= [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
                                         [[FoodManager sharedInstance].listOfFoodItems sortUsingDescriptors:[NSArray arrayWithObject:sortParam]];
                                         [self.tableView reloadData];
                                     }];
    
    [self.alertController addAction:cancelAction];
    [self.alertController addAction:abcAction];
    [self.alertController addAction:distanceAction];

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [FoodManager sharedInstance].listOfFoodItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    FoodItem *foodItem =  [FoodManager sharedInstance].listOfFoodItems[indexPath.row];
    cell.textLabel.text = foodItem.name;
    cell.imageView.image = foodItem.image;

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    self.detailVC.foodItem = [FoodManager sharedInstance].listOfFoodItems[indexPath.row];
    [self.navigationController pushViewController:self.detailVC animated:YES];
}
- (IBAction)sortByButtonPressed:(id)sender {
    
    [self presentViewController:self.alertController animated:YES completion:nil];
    
}
@end
