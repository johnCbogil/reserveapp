//
//  FoodItem.m
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "FoodItem.h"

@implementation FoodItem
- (id)initWithData:(NSDictionary *)data {
    self = [super init];
    if(self != nil) {
        self.name = [data valueForKey:@"name"];
        self.imageURL = [data valueForKey:@"image"];
        self.deliciosity = (int)[[data valueForKey:@"deliciosity"]integerValue];
        self.manufacturer = [data valueForKey:@"manufacturer"];
        self.dateAdded = [[data valueForKey:@"added"]doubleValue];
        self.sides = [data valueForKey:@"sides"];
        self.latitude = [[data valueForKey:@"location"][0]doubleValue];
        self.longitude = [[data valueForKey:@"location"][1]doubleValue];
        self.location = [[CLLocation alloc]initWithLatitude:self.latitude longitude:self.longitude];
        
        return self;
    }
    return self;
}
@end
