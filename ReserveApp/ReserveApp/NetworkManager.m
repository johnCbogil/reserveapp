//
//  NetworkingManager.m
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//
//  http://reserve-media.s3.amazonaws.com/test-data.json

#import "NetworkManager.h"

@implementation NetworkManager
+(NetworkManager *) sharedInstance
{
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        
    }
    return self;
}

- (void)getFoodData{
    
    
}
@end
