//
//  TTTStatusMenuDelegate.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 8/7/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTStatusMenuDelegate.h"
#import "TTTMatchRequest.h"

extern NSString* kRequestMatchTitle;
extern int kRequestMatchTag;
extern int kTimeRemainingTag;

@implementation TTTStatusMenuDelegate
{
    TTTMatchRequest *matchRequest;
}

- (id)initWithMatchRequest:(TTTMatchRequest *)givenMatchRequest
{
    self = [super init];
    if (self) {
        matchRequest = givenMatchRequest;
    }

    return self;
}

- (void)menuNeedsUpdate:(NSMenu *)menu
{
    NSMenuItem* awaitingMatchItem = [menu itemWithTag:kRequestMatchTag];
    NSMenuItem* timeRemainingForMatchItem = [menu itemWithTag:kTimeRemainingTag];

    if(matchRequest.pendingMatch) {
        awaitingMatchItem.title = @"Awaiting match...";
        awaitingMatchItem.enabled = NO;

        timeRemainingForMatchItem.hidden = NO;
        NSString *remainingTime = [NSString stringWithFormat:@"%d", ((int) matchRequest.timeLeftInRequest / 60) + 1];
        timeRemainingForMatchItem.title = [[@"Request alive for ~" stringByAppendingString:remainingTime] stringByAppendingString:@" more min(s)"];
    } else {
        awaitingMatchItem.title = kRequestMatchTitle;
        awaitingMatchItem.enabled = YES;

        timeRemainingForMatchItem.hidden = YES;
    }
}

@end
