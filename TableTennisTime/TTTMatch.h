//
//  TTTMatch.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 8/11/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTTRestClient;

@interface TTTMatch : NSObject

@property (strong) NSString *matchRequestGuid;
@property (strong) NSString *assignedTable;
@property (strong) NSArray *teams;
@property (strong) NSNumber *timeRemaining;

@property (assign) NSInteger scheduled;
@property (assign) BOOL matchFound;

- (id)initWithRestClient:(TTTRestClient *)restClient;
- (void)beginPollingForConfirmationWithJSON:(NSDictionary *)json;
- (void)acceptMatch;
- (void)rejectMatch;

@end
