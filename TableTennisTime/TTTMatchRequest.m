//
//  TTTMatchRequest.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/NSTimer.h>

#import "TTTMatchRequest.h"
#import "TTTRestClient.h"
#import "TTTResponse.h"
#import "TTTMatch.h"

#define POLLING_INTERVAL (10.0)

@implementation TTTMatchRequest
{
    NSUserDefaults* settings;
    TTTRestClient* client;
    TTTMatch* match;
    NSTimer* timer;
}

- (id)initWithSettings:(NSUserDefaults *)userSettings andRestClient:(TTTRestClient *)restClient andMatch:(TTTMatch *)givenMatch
{
    self = [super init];
    if (self) {
        settings = userSettings;
        client = restClient;
        match = givenMatch;
        [self refreshFromSettings];
    }

    return self;
}

- (void)createMatchFromOptions:(NSDictionary *)options onComplete: (void (^)(BOOL)) callback
{
    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [settings setObject:obj forKey:key];
    }];
    self.matchRequestDate = [NSDate date];
    [self refreshFromSettings];
    [client post:@"/match_requests" options:options callback:^(TTTResponse* resp){
        if ([resp success]) {
            self.pendingMatch = YES;
            self.pollingGuid = [[resp json] objectForKey:@"guid"];
            timer = [NSTimer scheduledTimerWithTimeInterval:POLLING_INTERVAL target:self selector:@selector(pollForMatchUpdates) userInfo:NULL repeats:YES];
            [timer fire];
        }
        callback([resp success]);
    }];
}

- (NSTimeInterval)timeLeftInRequest {
    return fmaxf([[NSDate dateWithTimeInterval:[self.requestTTL doubleValue] * 60 sinceDate:self.matchRequestDate] timeIntervalSinceNow], 0);
}

- (void) pollForMatchUpdates
{
    NSMutableString *path = [[NSMutableString alloc] initWithString:@"/match_requests/"];
    [path appendString: self.pollingGuid];
    [client get:path callback:^(TTTResponse *resp) {
        if(([resp statusCode] == 404) || [resp success]) {
            match.matchRequestGuid = self.pollingGuid;
            self.pendingMatch = NO;
            [timer invalidate];
            timer = nil;
            [match beginPollingForConfirmationWithJSON:[resp json]];
        }
    }];
}

- (void)refreshFromSettings
{
    [@[@"names", @"matchType", @"numPlayers", @"requestTTL"] enumerateObjectsUsingBlock:^(id key, NSUInteger index, BOOL *stop){
        [self setValue:[settings objectForKey:key] forKey:key];
    }];
}

@end
