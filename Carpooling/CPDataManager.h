//
//  CPDataManager.h
//  Carpooling
//
//  Created by Konstantin Gorbunov on 18/02/14.
//  Copyright (c) 2014 Konstantin Gorbunov. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kNotificationName = @"DataDownloadComplited";

@interface CPDataManager : NSObject

@property (readonly, strong, nonatomic) NSDictionary *cityMap;

+ (CPDataManager*)sharedManager;

- (void)loadData;

- (void)loadData:(int)countryIndex;

@end
