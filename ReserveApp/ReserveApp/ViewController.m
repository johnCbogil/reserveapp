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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
@end
