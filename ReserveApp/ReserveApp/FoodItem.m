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
        self.deliciosity = [data valueForKey:@"deliciosity"];
        self.location = [data valueForKey:@"location"];
        self.manufacturer = [data valueForKey:@"manufacturer"];
        self.dateAdded = [data valueForKey:@"added"];
        self.sides = [data valueForKey:@"sides"];
        
        return self;
    }
    return self;
}
@end
