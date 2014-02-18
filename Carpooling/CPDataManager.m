//
//  CPDataManager.m
//  Carpooling
//
//  Created by Konstantin Gorbunov on 18/02/14.
//  Copyright (c) 2014 Konstantin Gorbunov. All rights reserved.
//

#import "CPDataManager.h"
#import "AFNetworking.h"

@interface CPDataManager ()

@property (strong, nonatomic) NSDictionary *cityMap;

@end

static const int kDefaultCountry = 1;

static NSString *kUriFormat = @"http://www.mitfahrgelegenheit.de/lifts/getCities/%u";

@implementation CPDataManager

#pragma mark Singleton Methods

+ (CPDataManager*)sharedManager {
    static CPDataManager *sharedDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

- (id)init {
    if (self = [super init]) {
        self.cityMap = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)loadData {
    [self loadData:kDefaultCountry];
}

- (void)loadData:(int)countryIndex {
    
    NSString *parseURL = [NSString stringWithFormat:kUriFormat, countryIndex];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    __weak CPDataManager *weakSelf = self;
    [manager GET:parseURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Result: %@", responseObject);
        weakSelf.cityMap = (NSDictionary*)responseObject;
        
        //send notification
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName object:nil];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", [error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }];
    
}
@end