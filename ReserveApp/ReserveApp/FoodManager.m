//
//  FoodManager.m
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "FoodManager.h"
#import "NetworkManager.h"
#import "FoodItem.h"
#import "LocationService.h"

@implementation FoodManager
+ (FoodManager *)sharedInstance
{
    static FoodManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        self.listOfFoodItems = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)createFoodItemWithCompletion:(void(^)(void))successBlock
                  onError:(void(^)(NSError *error))errorBlock {
    
    [[NetworkManager sharedInstance]getFoodDataWithCompletion:^(NSArray *results) {
        NSMutableArray *listofFoodItems = [[NSMutableArray alloc]init];
        for (NSDictionary *resultDict in results) {
            FoodItem *foodItem = [[FoodItem alloc]initWithData:resultDict];
            
            [self assignDistanceFromCurrentLocation:foodItem];
            [self formatSides:foodItem];
            [self formatDate:foodItem];
            
            [self assignFoodItemImages:foodItem withCompletion:^{
                [listofFoodItems addObject:foodItem];
                successBlock();
            } onError:^(NSError *error) {
                errorBlock(error);
            }];
        }
        self.listOfFoodItems = listofFoodItems;

        successBlock();
//        NSLog(@"%@", self.listOfFoodItems);
        for (FoodItem *item in self.listOfFoodItems) {
            NSLog(@"%f", item.distanceFromLocation);
        }

    } onError:^(NSError *error) {
        
    }];
}

- (void)assignFoodItemImages:(FoodItem*)foodItem withCompletion:(void(^)(void))successBlock
                     onError:(void(^)(NSError *error))errorBlock {
    
    [[NetworkManager sharedInstance]getFoodImagesFromURL:foodItem.imageURL withCompletion:^(UIImage *results) {
        successBlock();
        foodItem.image = results;

    } onError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)assignDistanceFromCurrentLocation:(FoodItem*)foodItem{
    
    foodItem.distanceFromLocation = [[LocationService sharedInstance]getDistanceFromFoodItemLocation:foodItem.location];
}

- (void)formatSides:(FoodItem*)foodItem{
 
    NSLog(@"%@", foodItem.sides);
    foodItem.sides = [foodItem.sides valueForKey:@"name"];
    
}

- (void)formatDate:(FoodItem*)foodItem{
    // “10:30AM, January 5, 2015”.
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:foodItem.dateAdded];

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter* timeFormatter = [[NSDateFormatter alloc] init];

    [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
   // NSLog(@"%@ %@", [timeFormatter dateFromString:date], [dateFormatter dateFromString:date]);
    foodItem.dateString = [NSString stringWithFormat:@"%@, %@", [timeFormatter stringFromDate:date], [dateFormatter stringFromDate:date]];
    
}

@end
