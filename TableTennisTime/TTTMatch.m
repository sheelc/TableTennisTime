//
//  TTTMatch.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatch.h"
#import "TTTResponse.h"
#import <Foundation/NSTimer.h>

#define POLLING_INTERVAL (10.0)

@implementation TTTMatch
{
    NSUserDefaults* settings;
    TTTRestClient* client;
    NSTimer* timer;
}

- (id)initWithSettings:(NSUserDefaults*)userSettings andRestClient:(TTTRestClient*)restClient
{
    self = [super init];
    if (self) {
        settings = userSettings;
        client = restClient;
        [self refreshFromSettings];
    }

    return self;
}

- (void)createMatchFromOptions:(NSDictionary*)options onComplete: (void (^)(BOOL)) callback
{
    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop){
        [settings setObject:obj forKey:key];
    }];
    [self refreshFromSettings];
    [client post:@"/matches" options:options callback:^(TTTResponse* resp){
        if ([resp success]) {
            self.pollingGuid = [[resp json] objectForKey:@"guid"];
            timer = [NSTimer scheduledTimerWithTimeInterval:POLLING_INTERVAL target:self selector:@selector(pollForMatchUpdates) userInfo:NULL repeats:YES];
            [timer fire];
        }
        callback([resp success]);
    }];
}

- (void) pollForMatchUpdates
{
    NSMutableString* path = [[NSMutableString alloc] initWithString:@"/matches/"];
    [path appendString: self.pollingGuid];
    [client get:path callback:^(TTTResponse* resp) {
        if([resp success] && (self.opponentNames = [[resp json] objectForKey:@"opponentNames"])) {
            [timer invalidate];
            self.pollingGuid = NULL;
            timer = NULL;
        }
    }];
}

- (void)refreshFromSettings
{
    [@[@"names", @"matchType", @"numPlayers"] enumerateObjectsUsingBlock:^(id key, NSUInteger index, BOOL* stop){
        [self setValue:[settings objectForKey:key] forKey:key];
    }];
}

@end
