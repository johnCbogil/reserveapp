//
//  DetailViewController.m
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliciosityLabel;
@property (weak, nonatomic) IBOutlet UITextView *sidesTextView;
@property (weak, nonatomic) IBOutlet UIImageView *foodItemImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.foodItem.manufacturer;
    self.nameLabel.text = self.foodItem.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%f mi",self.foodItem.distanceFromLocation];
    self.distanceLabel.text = [self.distanceLabel.text substringToIndex: MIN(5, [self.distanceLabel.text length])];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ mi",self.distanceLabel.text];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", self.foodItem.dateString];
    self.deliciosityLabel.text = [NSString stringWithFormat:@"Deliciosity: %d%%", self.foodItem.deliciosity];
    if (self.foodItem.sides) {
        self.sidesTextView.text = [self.foodItem.sides componentsJoinedByString:@"\n"];
    }
    else{
        self.sidesTextView.text = @"This meal does not come with sides";
    }
    self.foodItemImageView.image = self.foodItem.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
