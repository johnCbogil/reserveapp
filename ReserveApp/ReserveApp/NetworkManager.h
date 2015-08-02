//
//  NetworkManager.h
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
+(NetworkManager *) sharedInstance;
- (void)getFoodDataWithCompletion:(void(^)(NSArray *results))successBlock
                          onError:(void(^)(NSError *error))errorBlock;
- (void)getFoodImagesFromURL:(NSString*)imageURL withCompletion:(void(^)(UIImage *results))successBlock
                     onError:(void(^)(NSError *error))errorBlock;
@property (nonatomic, strong)AFHTTPRequestOperationManager *manager;

@end
