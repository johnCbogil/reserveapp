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
            [listofFoodItems addObject:foodItem];
            self.listOfFoodItems = listofFoodItems;
        }
        successBlock();
//        NSLog(@"%@", self.listOfFoodItems);
        for (FoodItem *item in self.listOfFoodItems) {
            NSLog(@"%@", item.name);
        }

    } onError:^(NSError *error) {
        
    }];
}
@end
