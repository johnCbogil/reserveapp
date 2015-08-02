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
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic) int deliciosity;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) double dateAdded;
@property (nonatomic) NSString *dateString;
@property (nonatomic, strong) NSArray *sides;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CLLocationDistance distanceFromLocation;
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;




@end
