//
//  TTTMatch.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTRestClient.h"

@interface TTTMatch : NSObject

@property (strong) NSString* pollingGuid;
@property (strong) NSString* names;
@property (strong) NSString* opponentNames;
@property (strong) NSNumber* numPlayers;
@property (strong) NSString* matchType;

- (id)initWithSettings:(NSUserDefaults*)settings andRestClient:(TTTRestClient*)client;
- (void)createMatchFromOptions:(NSDictionary*)options onComplete: (void (^)(BOOL)) callback;
@end
