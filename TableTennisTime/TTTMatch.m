//
//  TTTMatch.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatch.h"

@implementation TTTMatch
{
    NSUserDefaults* settings;
    TTTRestClient* client;
}

- (TTTMatch*)initWithSettings:(NSUserDefaults*)userSettings andRestClient:(TTTRestClient*)restClient
{
    settings = userSettings;
    client = restClient;
    return self;
}

- (void)createMatchFromOptions:(NSDictionary*)options
{
    [client post:@"/matches" options:options callback:^(id resp){}];
}

@end
