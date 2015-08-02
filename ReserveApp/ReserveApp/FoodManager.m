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
    
    foodItem.distanceFromLocation =  [[LocationService sharedInstance]getDistanceFromFoodItemLocation:foodItem.location];
}

@end
