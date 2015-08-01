//
//  FoodManager.h
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodManager : NSObject
+(FoodManager *) sharedInstance;
@property (nonatomic, strong)NSMutableArray *listOfFoodItems;
- (void)createFoodItemWithCompletion:(void(^)(void))successBlock
                             onError:(void(^)(NSError *error))errorBlock;
@end
