//
//  TTTStatusMenuDelegate.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 8/7/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTStatusMenuDelegate.h"
#import "TTTMatch.h"

extern NSString* kRequestMatchTitle;
extern int kRequestMatchTag;
extern int kTimeRemainingTag;

@implementation TTTStatusMenuDelegate
{
    TTTMatch *match;
}

- (id)initWithMatch:(TTTMatch *)initMatch
{
    self = [super init];
    if (self) {
        match = initMatch;
    }

    return self;
}

- (void)menuNeedsUpdate:(NSMenu *)menu
{
    NSMenuItem* awaitingMatchItem = [menu itemWithTag:kRequestMatchTag];
    NSMenuItem* timeRemainingForMatchItem = [menu itemWithTag:kTimeRemainingTag];

    if(match.pollingGuid) {
        awaitingMatchItem.title = @"Awaiting match...";
        awaitingMatchItem.enabled = NO;

        timeRemainingForMatchItem.hidden = NO;
        NSString *remainingTime = [NSString stringWithFormat:@"%d", ((int) match.timeLeftInRequest / 60) + 1];
        timeRemainingForMatchItem.title = [[@"Request alive for ~" stringByAppendingString:remainingTime] stringByAppendingString:@" more min(s)"];
    } else {
        awaitingMatchItem.title = kRequestMatchTitle;
        awaitingMatchItem.enabled = YES;

        timeRemainingForMatchItem.hidden = YES;
    }
}

@end
