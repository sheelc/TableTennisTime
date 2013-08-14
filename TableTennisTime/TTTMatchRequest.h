//
//  TTTMatchRequest.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTTRestClient, TTTMatch;

@interface TTTMatchRequest : NSObject

@property (strong) NSString *pollingGuid;
@property (strong) NSString *names;
@property (strong) NSNumber *numPlayers;
@property (strong) NSString *matchType;
@property (strong) NSNumber *requestTTL;
@property (strong) NSDate *matchRequestDate;
@property (assign) BOOL pendingMatch;

- (id)initWithSettings:(NSUserDefaults *)settings andRestClient:(TTTRestClient *)client andMatch:(TTTMatch *)givenMatch;
- (void)createMatchFromOptions:(NSDictionary *)options onComplete: (void (^)(BOOL)) callback;
- (NSTimeInterval)timeLeftInRequest;

@end
