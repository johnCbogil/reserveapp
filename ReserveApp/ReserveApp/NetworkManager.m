//
//  NetworkingManager.m
//  ReserveApp
//
//  Created by John Bogil on 8/1/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//
//  http://reserve-media.s3.amazonaws.com/test-data.json

#import "NetworkManager.h"
#import "UIImageView+AFNetworking.h"


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
        self.manager = [AFHTTPRequestOperationManager manager];

    }
    return self;
}


- (void)getFoodDataWithCompletion:(void(^)(NSArray *results))successBlock
                             onError:(void(^)(NSError *error))errorBlock {
    NSDictionary *parameters = @{@"format": @"json"};
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager GET:@"http://reserve-media.s3.amazonaws.com/test-data.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success
                NSLog(@"JSON responseObject: %@ ",[responseObject valueForKey:@"food"]);
        successBlock([responseObject valueForKey:@"food"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //fail
        NSLog(@"error getting food data");
    }];
}

- (void)getFoodImagesFromURL:(NSString*)imageURL withCompletion:(void(^)(UIImage *results))successBlock
                          onError:(void(^)(NSError *error))errorBlock {
    
    NSURL *url = [NSURL URLWithString:imageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"%@", responseObject);
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
}

@end
