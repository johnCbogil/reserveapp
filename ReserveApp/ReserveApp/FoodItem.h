//
//  FoodItem.h
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FoodItem : NSObject
- (id)initWithData:(NSDictionary *)data;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSNumber *deliciosity;
@property (nonatomic)CLLocation *location;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSNumber *dateAdded;
@property (nonatomic, strong) NSDictionary *sides;


@end
